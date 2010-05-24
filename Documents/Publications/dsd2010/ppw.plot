
set terminal postscript eps enhanced colour font "Serif,34pt"

set style fill solid 1.0 noborder
set logscale y

set yrange [1:4000]
set ytics nomirror

set xrange [-0.5:5.5]
set xtics nomirror

set boxwidth 0.4 relative

set output "energy.eps"
plot "ppw.dat" using 1:3:xtic(2) notitle with boxes linecolor rgb "grey30",\
     "ppw.dat" using 1:3:3 notitle with labels offset 0,0.75

set output "energy-delay.eps"
plot "ppw.dat" using 1:4:xtic(2) notitle with boxes linecolor rgb "grey30",\
     "ppw.dat" using 1:4:4 notitle with labels offset 0,0.75
