
import json
import sys
import os
import numpy as np
import scipy as sp
import csv as csv
from tree_features import *
from scipy import *

# read a JSON file, returns the data from the file
def readJSON(JSONFile):
	#print "JSON File", JSONFile
	with open(JSONFile) as data_file:
		return json.load(data_file)

# generate a list of Tree objects based on the tree summary files in the trees_dict_path dictionary
def generateTreeList(trees_dict_path):
	list_tree_obj = []
	# trees_dict_path = sys.argv[1]
	all_json = os.listdir(trees_dict_path)
	#print all_json
	for tree_json_name in all_json:
		#print "tree json name", tree_json_name
		path = trees_dict_path + "/" + tree_json_name
		#print "path", path
		tree_summary = readJSON(path)
		all_trees = tree_summary["trees"]
		top_trees = sort_trees(all_trees, len(all_trees))
		for tree in top_trees:
			tree_obj = Tree(tree)
			list_tree_obj.append(tree_obj)
	return list_tree_obj

# sort the trees according to log likelihood, return a list of the top k trees
def sort_trees(trees, k):
	tree_track_dict = dict()
	llh_array = []
	trees_return = []
	for tree_idx in trees:
		tree = trees[tree_idx]
		tree_llh = tree["llh"]
		llh_array.append(tree_llh)
		tree_track_dict[tree_llh] = tree_idx
	sorted_llh_array = sorted(llh_array)
	top_k_llh = sorted_llh_array[:k]
	for llh in top_k_llh:
		top_tree_idx = tree_track_dict[llh]
		top_tree = trees[top_tree_idx]
		trees_return.append(top_tree)
	return trees_return

# generates a feature matrix for k-means clustering based on a list of Tree objects, using the specified feature. the matrix 
def generateFeatureMatrix(tree_list, feature):
	featureList = []
	featureDict = dict()
	for i in xrange(len(tree_list)):
		tree_feature = getattr(tree_list[i], feature)
		featureDict[i] = tree_feature
		featureList.append(tree_feature)
	feature_array = np.array(featureList)
	return feature_array

# perform k-means clustering given a feature matrix, value of k, number of iterations
def k_means(featureMatrix, k, num_iter):
	return sp.cluster.vq.kmeans2(featureMatrix, k, num_iter)

#CSV file where each row is population prevalence per tree. Most likely trees are in first columns
def generatePrevalenceMatrix(tree_list):
	pop_prev_all = {}
	#names = ["Population"]
	#print len(tree_list)
	for i in xrange(len(tree_list)):
		tree = tree_list[i]
		#names.append("CP "+str(i)) #Colnames = cell prevalence in tree i
		for pop_idx in tree.cellular_prevalence.keys():
			#print "pop_idx", pop_idx
			newCellPrev = mean(tree.cellular_prevalence[pop_idx])
			#print type(newCellPrev)
			if pop_idx in pop_prev_all.keys():
				pop_prev_all[pop_idx].append(newCellPrev)
			else:
				pop_prev_all[pop_idx] = [pop_idx, newCellPrev]
	list2d =[]
	maxLen = 0
	for key in pop_prev_all.keys():
		row = pop_prev_all[key]
		list2d.append(row)
		if len(row)>maxLen:
			maxLen=len(row)
	print "MAX LENGTH: ", maxLen
	#formats = ['f8']*(len(tree_list)+1)
	#print "list2d", len(list2d)
	#cell_prev_array = np.array(list2d, dtype='f8')
	#print "list2d", list2d
	#print "cellArray", repr(cell_prev_array)
	print "NROWS", len(list2d)
	return list2d

# read input from the command line and generate a cellular matrix used for statistical analysis in R
# first argument is the path to the directory with the tree sumary JSON files, the second argument is the name for the file
def main():
	dict_path = sys.argv[1]
	name = sys.argv[2]
	treeList = generateTreeList(dict_path)
	cpMatrix = generatePrevalenceMatrix(treeList)
	# generate csv file, gets saved to wd
	csvwriter = csv.writer(open("cpMatrix_"+name+".csv", 'wb'))
	csvFile = csvwriter.writerows(cpMatrix)

main()
test_pop = {"0" : {"num_ssms" : 1, "num_cnvs":1, "cellular_prevalence":[1.0]}, "1" : {"num_ssms":2, "num_cnvs":2, "cellular_prevalence":[1.0]}, "2":{"num_ssms":2, "num_cnvs":2, "cellular_prevalence":[1.0] }}
test_tree = {"populations" : test_pop, "structure" : {"0":[1,2]}}