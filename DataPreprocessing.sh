#!/bin/bash

# Constructing CSV Format
cat Scripture_Raw.txt |\
	sed 's/ KJV\] /",/g' |\
	sed 's/\[/"/' |\
	sed 's/\s/","/' |\
	sed 's/\:/","/' |\
	sed -e '1i"Book","Chapter","Verse","Text"\' \
	> Scripture_TextAndStrongs.csv

# Constructing Scripture Text Only CSV Format
cat Scripture_TextAndStrongs.csv |\
	sed -e 's/\[[^][]*\]//g' \
	> Scripture_Text.csv


# Constructing Strongs Numbers only CSV Format
cat Scripture_TextAndStrongs.csv |\
	sed 's/\(^\|]\)[^][]*\(\[\|$\)/\1\2/g' |\
	sed 's/\]\[/,/g' |\
	sed 's/\[/"/g' |\
	sed 's/\]/"/g' |\
	sed -e '1d' |\
	sed -e '1i"Strongs"\' \
	> Scripture_StrongsA.csv

# Concat scripture refs into strongs numbers
cut -d "," -f 1-3 Scripture_TextAndStrongs.csv > Scripture_Refs.csv
paste -d "," Scripture_Refs.csv Scripture_Strongs.csv |\
	awk -F',' '{print $0}' \
	> Scripture_StrongsB.csv

