#!/bin/bash

# Constructing CSV Format
cat Scripture_Raw.txt |\
	sed 's/ KJV\] /",/g' |\
	sed 's/\[/"/' |\
	sed 's/\s/","/' |\
	sed 's/\:/","/' |\
	sed -e '1i"Book","Chapter","Verse","Text"\'

# Constructing Scripture Text Only CSV Format


# Constructing Strongs Numbers only CSV Format


