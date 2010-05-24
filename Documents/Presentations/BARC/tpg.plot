
set title "Throughput / Area\n(jobs per second / gate)" font "Times-Roman,24pt"

set terminal postscript eps enhanced colour font "Times-Roman,20pt"
set output "tpg.eps"

set style line 101 linecolor rgb "grey20"
set style line 102 linecolor rgb "grey40"
set style line 103 linecolor rgb "grey60"

set style fill solid 1.0 noborder
set logscale y

set yrange [0.0001:1e+07]
set xtics ("Linpack" 0, "R-B Trees" 1, "FFT" 2, "A5/1" 3, "AES" 4)

plot "performance-area-ratio.dat" using 2 title "P-4" with histograms linestyle 101, \
     "performance-area-ratio.dat" using 3 title "AHIR" with histograms linestyle 102, \
     "performance-area-ratio.dat" using 4 title "RTL" with histograms linestyle 103
