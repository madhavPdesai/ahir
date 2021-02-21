gcc -g -c -I./ common.c
gcc -g -c -I./ generate_mem_cut_files.c
gcc -g -o generate_mem_cut_files generate_mem_cut_files.o common.o
gcc -g -c -I./ generate_mem_cut_fpga_wrappers.c
gcc -g -o generate_mem_cut_fpga_wrappers generate_mem_cut_fpga_wrappers.o common.o
