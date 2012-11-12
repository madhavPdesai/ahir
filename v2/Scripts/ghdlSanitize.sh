echo "library ahir; use ahir.Types.all;" > $2
sed 's/STD_LOGIC_VECTOR ( 8 downto -23 )/IStdLogicVector(8 downto -23)/' < $1 >> $2
