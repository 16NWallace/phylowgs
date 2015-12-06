
import json
import sys
import os
import numpy as np
import scipy as sp
from tree_features import *
from scipy import *
from scipy.cluster import *

# read a JSON file, returns the data from the file
def readJSON(JSONFile):
	with open(JSONFile) as data_file:
		return json.load(data_file)

# generate a list of Tree objects based on the tree summary files in the trees_dict_path dictionary
def generateTreeList(trees_dict_path):
	list_tree_obj = []
	# trees_dict_path = sys.argv[1]
	all_json = os.listdir(trees_dict_path)
	print all_json
	for tree_json_name in all_json:
		path = trees_dict_path + "/" + tree_json_name
		print path
		tree_summary = readJSON(path)
		all_trees = tree_summary["trees"]
		top_10_trees = sort_trees(all_trees, 10)
		for tree in top_10_trees:
			tree_obj = Tree(tree)
			list_tree_obj.append(tree_obj)
		# for tree_idx in all_trees:
		# 	tree_obj = Tree(all_trees[tree_idx])
		# 	list_tree_obj.append(tree_obj)
		# top_tree = tree_summary["trees"]["0"]
		# top_tree_obj = Tree(top_tree)
		# list_tree_obj.append(top_tree_obj)
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

# read input from the command line and generate a feature matrix for k-means clustering which will be done in R
# first argument is the path to the directory with the tree sumary JSON files, the second argument is the feature, the third argument is the name for the file
def main():
	dict_path = sys.argv[1]
	feature = sys.argv[2]
	name = sys.argv[3]
	treeList = generateTreeList(dict_path)
	featureMatrix = generateFeatureMatrix(treeList)
	# generate csv file
	csv = np.savetxt("matrix_"+feature+"_"+name+".csv", featureMatrix)

main()
test_pop = {"0" : {"num_ssms" : 1, "num_cnvs":1, "cellular_prevalance":[1.0]}, "1" : {"num_ssms":2, "num_cnvs":2, "cellular_prevalance":[1.0]}, "2":{"num_ssms":2, "num_cnvs":2, "cellular_prevalance":[1.0] }}
test_tree = {"populations" : test_pop, "structure" : {"0":[1,2]}}
