
set title "Performance per Watt" font "Times-Roman,24pt"

set terminal postscript eps enhanced colour font "Times-Roman,20pt"
set output "ppw.eps"

set style fill solid 1.0 noborder
set logscale y

set yrange [1:1000]
set xtics ("Linpack" 0, "R-B Trees" 1, "FFT" 2, "A5/1" 3, "AES" 4)

plot "performance-per-watt.dat" using 2 title "" with histograms linecolor rgb "grey30"
