#!/bin/bash

FILES=/Users/nadiawallace/Documents/nbinom_empty_sims/*

mkdir nb_results2
for file in $FILES
do
	FILENAME=$(basename "$file")
	echo $FILENAME
	FILENAME=${FILENAME%.txt}  
	python2 evolve.py -B 25 -s 500 -i 1000 -n $file cnv_empty.txt
	mkdir nb_results2/nb_results2_$FILENAME
	cd nb_results2/nb_results2_$FILENAME
	python2 ../../write_results.py nb_results2_$FILENAME ../../trees.zip nb_results2_$FILENAME.summ.json.gz nb_results2_$FILENAME.muts.json.gz nb_results2_$FILENAME.mutass.zip
	cd ../..
done 
