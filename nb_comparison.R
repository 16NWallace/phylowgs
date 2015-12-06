install.packages("plotrix")
library("plotrix")

binom_path<-"~/Documents/Classes/Fall\ 2015/6.047/phylowgs/cpMatrix_binom2.csv"
nb_path<-"~/Documents/Classes/Fall\ 2015/6.047/phylowgs/cpMatrix_negbinom2.csv"

binom_table<-read.csv(binom_path, col.names = paste0("V",seq_len(max(count.fields(binom_path, sep=",")))),stringsAsFactors=FALSE, header=FALSE, fill=TRUE)
negbinom_table<-read.csv(nb_path, col.names = paste0("V",seq_len(max(count.fields(nb_path, sep=",")))), stringsAsFactors=FALSE, header=FALSE, fill=TRUE)

#Format tables
format_table<-function(m_table){
  m_table<-m_table[order(m_table[,1]),]
  row.names(m_table)<-m_table[,1]
  m_table<-m_table[,2:23001]
}

binom_table<-format_table(binom_table)
negbinom_table<-format_table(negbinom_table)

#Generate Summary tables w.u,std, var for each pop'l per table
get_summ_table<-function(row_vec){
  row_vec<-t(row_vec)
  row_vec<-as.numeric(row_vec)
  stderr<-std.error(row_vec)
  ans<-c(mean(row_vec, na.rm=TRUE), stderr, quantile(row_vec, 0.25, na.rm=TRUE), quantile(row_vec, 0.50, na.rm=TRUE), quantile(row_vec, 0.75, na.rm=TRUE))
}

format_summ_table<-function(m_table){
  m_summ<-apply(m_table, 1, get_summ_table)
  row.names(m_summ)<-c("Mean", "Standard Error", "25%", "50%", "75%")
  m_summ<-t(m_summ)
}
binom_summ<-format_summ_table(binom_table)
negbinom_summ<-format_summ_table(negbinom_table)

#Generate Aggregate table of std, var, m
na_pad<-c(NA, NA)
full_summ<-cbind(binom_summ[,"Mean"], append(negbinom_summ[,"Mean"], na_pad), 
                 binom_summ[,"Standard Error"], append(negbinom_summ[,"Standard Error"], na_pad), 
                 binom_summ[,"25%"], append(negbinom_summ[,"25%"], na_pad), 
                 binom_summ[,"50%"], append(negbinom_summ[,"50%"], na_pad),
                 binom_summ[,"75%"], append(negbinom_summ[,"75%"], na_pad))
full_summ<-round(full_summ, 4)
colnames(full_summ)<-c("B Mean", "NB Mean",
                        "B StdErr", "NB StdErr",
                        "B 25%", "NB 25%",
                        "B 50%", "NB 50%",
                        "B 75%", "NB 75%")

#Row by row Mann-Whitney-Wilcoxon test
#Null hypothesis - binom cell prevalences and neg binom cell prevalences are from the
#same distribution
get_mww_row<-function(idx){
  nb<-as.numeric(negbinom_table[idx,])
  b<-as.numeric(binom_table[idx,])
  ans<-wilcox.test(nb, b, paired=FALSE, exact=FALSE)
}

mww_table<-sapply(seq(length=nrow(negbinom_table)), get_mww_row)
mww_table<-t(mww_table[c("statistic", "p.value", "alternative"),])
rownames(mww_table)<-0:14

#Row by row Chi-squared test - compare average cell prevalences per population
conting_table<-cbind(binom_summ[,"Mean"], append(negbinom_summ[,"Mean"], na_pad))
chi_sq_table<-chisq.test(conting_table[15,])
