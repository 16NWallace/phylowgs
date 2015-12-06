#!/bin/bash

FILES=/Users/avasoleimany/phylowgs/depth_300_all/*

for dir in $FILES
do
	DIRNAME=$(basename "$dir")
	TAG=${DIRNAME:13}
	cd $dir
	mv data_1.summ.json data_$TAG.summ.json
	mv data_$TAG.summ.json /Users/avasoleimany/phylowgs/depth_300_summ
	cd ..
done 
