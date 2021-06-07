echo "library ahir; use ahir.Types.all;" > $2
cat $1 | sed 's/STD_LOGIC_VECTOR ( 8 downto -23 )/IStdLogicVector(8 downto -23)/' | sed 's/STD_LOGIC_VECTOR ( 8 downto -1 )/IStdLogicVector(8 downto -1)/' | sed 's/STD_LOGIC_VECTOR ( 11 downto -1 )/IStdLogicVector(11 downto -1)/' | sed 's/STD_LOGIC_VECTOR ( 11 downto -52 )/IStdLogicVector(11 downto -52)/'  >> $2
