#!/bin/bash

MAIN_NB=nb_results2/*

mkdir nb_results2/all_summ_json
for dir in $MAIN_NB
do
	cd $dir
	DIRNAME=${PWD##*/}
	#FILENAME=${DIRNAME:10}
	#mv *.mutass.zip nb_results2_$FILENAME.mutass.zip
	cp nb_results2*.summ.json.gz ../all_summ_json/$DIRNAME.summ.json.gz
	cd ../..
done
