import util2 as u
from scipy.stats import nbinom
from numpy import mean

###DEPRECATED: THIS FINDS NEGATIVE BINOMIAL PROBABILITY, NOT AVERAGE LIKELIHOOD
def testNegBinomNoSd(k, r, mu):
	truth = nbinom.logpmf(k,r,mu)
	val = u.log_neg_binom_likelihood(k,r,mu)
	return truth==val

def testNegBinomWSd(k, r, mu, sd):
	truth = mean([nbinom.logpmf(k, i, mu) for i in range(int(r-0.5*sd),int(r+0.5*sd)+1)])
	val = u.log_neg_binom_likelihood(k,r,mu,sd)
	print truth, val
	return truth==val

def main():
	#Stdev == 0, no offset, single sample
	print testNegBinomNoSd(15,10,0.3)
	#Test with standard dev integer
	print testNegBinomWSd(15,10,0.3,2)
	#Test with standard dev decimal
	print testNegBinomWSd(15,10,0.3,2.5)

main()