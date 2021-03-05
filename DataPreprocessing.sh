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


