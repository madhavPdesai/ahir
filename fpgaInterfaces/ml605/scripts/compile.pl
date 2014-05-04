#!/usr/local/bin/perl


######## shell commands #########
use Cwd;
use File::Find;
use File::Copy;
$dir = getcwd();
$remove = "rm";         #remove call
$force = "-rf";	       #force switch
$l = "/";               #slash direction
$xstdir = "${dir}${l}xst"; 
$copyf = "cp";
$move = "mv";          #move call
$createFile = "touch";
$oplist = "${xstdir}${l}flFinal.prj";
$bothXST = "${xstdir}${l}both.prj";
$ethXST = "${xstdir}${l}ethernet.prj";
$pcieXST = "${xstdir}${l}pcie.prj";
$userDirec = "$dir${l}..${l}user";
$XST_SCR = "${xstdir}${l}both.scr";
$NGDBUILD_UCF = "${dir}${l}..${l}ucf${l}both.ucf";
$fileType = "vhdl";
$package = 1;
####### initialization ########
&cleanup;
&getPackage;


####### generate final list of files #########
opendir(my $dh,$userDirec);
system("$remove $force $oplist");
system("$createFile $oplist");
if ($package == 1){	
	system("$copyf $ethXST $oplist");
	$XST_SCR = "${xstdir}${l}ethernetXST.scr";
	$NGDBUILD_UCF = "${dir}${l}..${l}ucf${l}ethernet.ucf";
}
elsif ($package == 2){	
	system("$copyf $pcieXST $oplist");
	$XST_SCR = "${xstdir}${l}pcieXST.scr";
	$NGDBUILD_UCF = "${dir}${l}..${l}ucf${l}pcie.ucf";
}
elsif ($package == 3){	
	system("$copyf $bothXST $oplist");
	$XST_SCR = "${xstdir}${l}bothXST.scr";
	$NGDBUILD_UCF = "${dir}${l}..${l}ucf${l}both.ucf";
}
else {
	print "wrong option specified. Lets go once again \n";
	&getPackage;
}
my @file = readdir($dh);
open(MYFILE, ">>", $oplist);
print MYFILE "\n\n\#User Filenames \n\n";
foreach(@file){
	my @chars = split("", $_);
	my $flag = 1;
	foreach(@chars){
		if ($_ ne '.'){
			$flag = 0;
		}
	}
	if ($flag == 0){
		@chars = split(/\//, $_);	
		my $numSubs = @chars;
		my $fileName = $chars[$numSubs-1];
		@chars = split(/\./, $fileName);
		$numSubs = @chars;
		if ($numSubs != 2){
			print "ERROR : This filename is not correct - $_. Too many full stops in it. Any further execution of script is being terminated";
			exit 1;
		}
		elsif ($chars[1] eq "vhd"){
			$fileType = "vhdl";
		}
		elsif ($chars[1] eq "vhdl"){
			$fileType = "vhdl";
		}
		elsif ($chars[1] eq "v"){
			$fileType = "verilog";
		}
		else{
			print "ERROR : This filename is not correct - $_. File extension is wrong. Any further execution of script is being terminated";
			exit 1;
		}
		print MYFILE "${fileType} work ${userDirec}${l}$_ \n";
	}	
}
closedir $dh;
close (MYFILE);


######### OPTIONS FOR GENERATING BITSTREAM #########
$NGDBUILD_OPTIONS = "-intstyle silent -dd _ngo -nt timestamp -p xc6vlx240t-ff1156-1"; 

$MAP_OPTIONS      = "-intstyle ise -p xc6vlx240t-ff1156-1 -w -logic_opt off -ol high -xe n -t 3 -xt 0 -register_duplication off -r 4 -global_opt speed -mt on -detail -ir off -pr off -lc off -power off"; 

$PAR_OPTIONS      = "-w -intstyle ise -ol high"; 

$TRCE_OPTIONS     = "-u 20 -v 200";

$BITGEN_OPTIONS   = "-w -f bitgen.ut";



&run_synthesis;
&run_ngdbuild;
&run_map;
&run_par;
&run_trce;
&run_bitgen;
print ("\n bitfile succesfully generated\n\n");














############# function definitions ################

sub run_synthesis
{
  print ("\nStarting synthesis\n");
  $status = 0;
  $status = system("xst -ifn $XST_SCR -intstyle silent");
  if($status != 0)
  {
    print ("ERROR: Synthesis produced errors. \nTerminating any further execution of script\n");
    exit 1;
  }
  system("$move design.ngc ${dir}${l}results${l}");
  print ("Synthesis complete\n");  
}


sub run_ngdbuild
{
  print ("\nStarting NGDBUILD\n");

  $command = "ngdbuild $NGDBUILD_OPTIONS -uc $NGDBUILD_UCF -sd ${dir}${l}..${l}..${l}..${l} ${dir}${l}results${l}design.ngc";
  print ("$command\n");
  $status = 0;
  $status = system ("$command");
  if($status != 0)
  {
    print ("ERROR: NGDBUILD produced errors. \nTerminating any further execution of script\n");
    exit 1;
  }
  print ("NGDBUILD complete\n");
}


sub run_map
{
  system("$move design.ngd ${dir}${l}results${l}design.ngd");
  system("$move design.bld ${dir}${l}results${l}design.bld");

  print ("\nStarting MAP\n");
  $MAPTARGET = $TARGET_NAME . "_map";

  $command = "map $MAP_OPTIONS -o ${dir}${l}results${l}mapped.ncd ${dir}${l}results${l}design.ngd ${dir}${l}results${l}mapped.pcf";
  $status = 0;
  $status = system ("$command");
  if($status != 0)
  {
    print ("ERROR: MAP produced errors.\nTerminating any further execution of script\n");
    print ("\n");
    exit 1;
  }
  print ("MAP complete\n");
}


sub run_par
{
  print ("\nStarting PAR\n");

  $command = "par $PAR_OPTIONS ${dir}${l}results${l}mapped.ncd ${dir}${l}results${l}routed.ncd ${dir}${l}results${l}mapped.pcf";
  $status = 0;
  $status = system ("$command");
  if($status != 0)
  {
    print ("ERROR: PAR produced errors.\nTerminating any further execution of script\n");
    print ("\n");
    exit 1;
  }
  print ("PAR complete\n");
}


sub run_trce
{
  print ("\nStarting TRCE\n");

  $command = "trce $TRCE_OPTIONS ${dir}${l}results${l}routed.ncd ${dir}${l}results${l}mapped.pcf";
  $status = 0;
  $status = system ("$command");
  if($status != 0)
  {
    print ("ERROR: TRCE produced errors. Terminating any further execution of script\n");
    print ("\n");
    exit 1;
  }
    print ("TRCE complete\n");
}


sub run_bitgen
{
  print ("\nStarting BITGEN\n");
  $command = "bitgen -w ${dir}${l}results${l}routed.ncd";
  $status = 0;
  $status = system ("$command");
  if($status != 0)
  {
    print ("ERROR: BITGEN produced errors. Terminating any further execution of script\n");
    print ("\n");
    exit 1;
  }
  print ("INFO: BITGEN complete\n");
}


sub cleanup {
  print "\nClean up the results directory\n";
  system("$remove $force *.xst");
  system("$remove $force *.srp");
  system("$remove $force results");
  system("$remove $force reports");
  system("mkdir results");
  system("mkdir reports");
}

sub getPackage{
  print "Which interface you want to use? Type the corresponding index number\n";
  print "1 for ethernet\n";
  print "2 for pcie\n";
  print "3 for both\n";
  $package = <STDIN>;
}

########## Arrangment & Cleanup after completion #######
system("$move *.twr ${dir}${l}results${l}");
system("$move *.twx ${dir}${l}results${l}");
system("$remove $force *.xrpt");
system("$remove $force *.xml");
system("$remove $force *.lst");
system("$remove $force *.lso");
system("$remove $force *.ngr");
system("$remove $force _ngo");
system("$remove $force xlnx_auto_0_xdb");
system("$remove $force ${xstdir}${l}dump.xst"); 
system("$remove $force ${xstdir}${l}work"); 
system("$remove $force ${xstdir}${l}ahir"); 
system("$remove $force ${xstdir}${l}ahir_ieee_proposed"); 
system("$move *.srp ${dir}${l}reports${l}");
