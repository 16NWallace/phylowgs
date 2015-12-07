#!/bin/bash

FILES=/Users/avasoleimany/phylowgs/depth_300_all_v2/*

for dir in $FILES
do
	DIRNAME=$(basename "$dir")
	TAG=${DIRNAME:13}
	cd $dir
	mv data_.summ.json data_$TAG.summ.json
	cp data_$TAG.summ.json /Users/avasoleimany/phylowgs/depth_300_summ_v2
	cd ..
done 
