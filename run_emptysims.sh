#!/bin/bash

FILES=/Users/avasoleimany/phylowgs/emptysims/*

for file in $FILES
do
	FILENAME=$(basename "$file")
	FILENAME=${FILENAME%.txt}  
	python2 evolve.py -B 10 -s 500 -i 1000 $file cnv_empty.txt
	mkdir test_results_v2_$FILENAME
	cd test_results_v2_$FILENAME
	python2 ~/phylowgs/write_results.py data_v2_$FILENAME ../trees.zip data_$count.summ.json.gz data_v2_$FILENAME.muts.json.gz data_v2_$FILENAME.mutass.zip
	cd ..
done 
