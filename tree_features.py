import json
import sys

class Tree:
	def __init__(self, treeJSON):
		self.json_data = treeJSON
		self.max_ssms = max_ssms(treeJSON)
		self.max_cnvs = max_cnvs(treeJSON)
		self.max_branching = max_branching(treeJSON)
		self.num_pop = num_pop(treeJSON)
		self.num_leaves = num_leaves(treeJSON)
		self.tree_height = tree_height(treeJSON)
		self.avg_ssms = avg_ssms(treeJSON)
		self.avg_cnvs = avg_cnvs(treeJSON)
		self.avg_children = avg_children(treeJSON)
		self.cellular_prevalence = cell_prevalence(treeJSON)

	def get_max_ssms():
		return self.max_ssms
	def get_max_cnvs():
		return self.max_cnvs
	def get_num_pop():
		return self.num_pop
	def get_num_leaves():
		return self.num_leaves
	def get_tree_height():
		return self.tree_height
	def get_avg_ssms():
		return self.avg_ssms
	def get_avg_cnvs():
		return self.avg_cnvs
	def get_cell_prev():
		return self.cellular_prevalence

# finds the maximum number of SSMs among the populations in a tree
def max_ssms(tree):
	populations = tree["populations"]
	max_ssms = 0
	for pop_idx in populations:
		pop_ssms = populations[pop_idx]["num_ssms"]
		if pop_ssms > max_ssms:
			max_ssms = pop_ssms
	return max_ssms

# finds the maximum number of CNVs amongst populations in a tree
def max_cnvs(tree):
	populations = tree["populations"]
	max_cnvs = 0
	for pop_idx in populations:
		population = populations[pop_idx]
		pop_cnvs = population["num_cnvs"]
		if pop_cnvs > max_cnvs:
			max_cnvs = pop_cnvs
	return max_cnvs

# finds the maximum degree of branching (maximum outdegree/descendant subclone) amongst populations in a tree
def max_branching(tree):
	structure = tree["structure"]
	max_children = 0
	for internal in structure:
		num_children = len(structure[internal])
		if num_children > max_children:
			max_children = num_children
	return max_children

# determines the total number of populations (subclones) in a tree, discounting the dummy 0 population
def num_pop(tree):
	populations = tree["populations"]
	pop_count=0
	for pop_idx in populations:
		pop_ssms = populations[pop_idx]["num_ssms"]
		if pop_ssms == 0:
			continue
		pop_count+=1
	return pop_count

# determines the number of leaves (populations with no descendants) in a tree, discounting the dummy 0 node
def num_leaves(tree):
	tree_pop = num_pop(tree)
	tree_structure = tree["structure"]
	num_internal = len(tree_structure)
	return tree_pop - num_internal

# determines the height/depth of a tree, discounting the dummy 0 node
def tree_height(tree):
	tree_structure = tree["structure"]
	num_internal = len(tree_structure)
	return num_internal

# determines the average number of SSMs in populations of a tree
def avg_ssms(tree):
	populations = tree["populations"]
	sum_ssms = 0
	for pop_idx in populations:
		pop_ssms = populations[pop_idx]["num_ssms"]
		sum_ssms += pop_ssms
	return float(sum_ssms) / num_pop(tree)

# determines the average number of CNVs in a set of populations of a tree
def avg_cnvs(tree):
	populations = tree["populations"]
	sum_cnvs = 0
	for pop_idx in populations:
		pop_cnvs = populations[pop_idx]["num_cnvs"]
		sum_cnvs += pop_cnvs
	return float(sum_cnvs) / num_pop(tree)

# determines the average number of children of subclones in a tree, meant as a measure of branching
def avg_children(tree):
	structure = tree["structure"]
	total_children = 0
	subclones = num_pop(tree)
	for internal in structure:
		# discount the dummy node
		if internal == "0":
			continue
		total_children += len(structure[internal])
	return float(total_children) / float(subclones)

#Get cellular prevalence values for distribution
def cell_prevalence(tree):
	populations = tree["populations"]
	pop_prev = {}
	for pop_idx in populations.keys():
		pop_prev[pop_idx] = populations[pop_idx]["cellular_prevalence"]
	return pop_prev


