#!/bin/bash

FILES=/Users/avasoleimany/phylowgs/emptysims/*

for file in $FILES
do
	FILENAME=$(basename "$file")
	FILENAME=${FILENAME%.txt}  
	python2 evolve.py -B 1000 -s 2500 -i 5000 $file cnv_empty.txt
	mkdir test_results_v3_$FILENAME
	cd test_results_v3_$FILENAME
	python2 ~/phylowgs/write_results.py data_v3_$FILENAME ../trees.zip data_$count.summ.json.gz data_v3_$FILENAME.muts.json.gz data_v3_$FILENAME.mutass.zip
	cd ..
done 
