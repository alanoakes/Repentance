#!/bin/bash

# Constructing CSV Format
cat Scripture_Raw.txt |\
	sed 's/ KJV\] /",/g' |\
	sed 's/\[/"/' |\
	sed 's/\s/","/' |\
	sed 's/\:/","/' |\
	sed -e '1i"Book","Chapter","Verse","Text"\' \
	> ../Data/Scripture_TextAndStrongs.csv

# Constructing Scripture Text Only CSV Format
cat Scripture_TextAndStrongs.csv |\
	sed -e 's/\[[^][]*\]//g' \
	> ../Data/Scripture_Text.csv

# Constructing Strongs Numbers only CSV Format
cat Scripture_TextAndStrongs.csv |\
	sed 's/\(^\|]\)[^][]*\(\[\|$\)/\1\2/g' |\
	sed 's/\]\[/,/g' |\
	sed 's/\[/"/g' |\
	sed 's/\]/"/g' |\
	sed -e '1d' |\
	sed -e '1i"Strongs"\' \
	> ../Data/Scripture_StrongsA.csv

# Concat scripture refs into strongs numbers
cut -d "," -f 1-3 Scripture_TextAndStrongs.csv > Scripture_Refs.csv
paste -d "," Scripture_Refs.csv Scripture_StrongsA.csv |\
	awk -F',' '{print $0}' \
	> ../Data/Scripture_StrongsB.csv

# Construct kjv word repent paired with its strongs number
cat Scripture_TextAndStrongs.csv |\
	awk -F',' '{print $4}' |\
	sed 's/.*repent\(.*\)\]/\1/' |\
	awk -F']' '{print $1}' |\
	sed 's/^/repent/g' \
	> ../Data/test
