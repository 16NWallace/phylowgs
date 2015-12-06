num_pop_data <- read.table("/Users/avasoleimany/phylowgs/matrix_num_pop_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
num_pop_data$size <- 0
num_pop_kmeans <- kmeans(num_pop_data, 4, iter.max = 100)
num_pop_plot <- plot(num_pop_data[,1], num_pop_data[,2], xlab="Number of Populations", yaxt="n", ylab="", col=num_pop_kmeans$cluster)


avg_ssms_data <- read.table("/Users/avasoleimany/phylowgs/matrix_avg_ssms_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
avg_ssms_data$size <- 0
avg_ssms_dist <- dist(avg_ssms_data[,1], method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
avg_ssms_hierarchical <- hclust(avg_ssms_dist, method = "euclidean", members = NULL)
avg_ssms_hierarchical_plot <- plot(avg_ssms_hierarchical, xlab = "Average number of SSMs/population", hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE, labels=FALSE,
     sub = NULL, main = NULL, ylab = "Height")
avg_ssms_kmeans <- kmeans(avg_ssms_data, 6, iter.max = 100)
avg_ssms_plot <- plot(avg_ssms_data[,1], avg_ssms_data[,2], xlab="Average number of SSMs/population", yaxt="n", ylab="", col=avg_ssms_kmeans$cluster)

avg_cnvs_data <- read.table("/Users/avasoleimany/phylowgs/matrix_avg_cnvs_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
avg_cnvs_data$ssms <- avg_ssms_data[,1]
avg_ssms_cnvs_kmeans <- kmeans(avg_cnvs_data, 6, iter.max = 100)
avg_ssms_cnvs_plot <- plot(avg_cnvs_data[,2], avg_cnvs_data[,1], xlab="Average number of SSMs/population", ylab="Average number of CNVs/population", col=avg_ssms_cnvs_kmeans$cluster)

total_ssms_data <- read.table("/Users/avasoleimany/phylowgs/matrix_total_ssms_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
total_ssms_data$size <- 0
total_ssms_kmeans <- kmeans(total_ssms_data, 15, iter.max = 100)
total_ssms_plot <- plot(total_ssms_data[,1], total_ssms_data[,2], xlab="Total number of SSMs/tree", yaxt="n", ylab="", col=total_ssms_kmeans$cluster)

num_pop_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_pop_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
avg_ssms_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_avg_ssms_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
num_pop_data_init$ssms <- avg_ssms_data_init[,1]
avg_ssms_num_pop <- kmeans(num_pop_data_init, 4, iter.max = 100)
avg_ssms_pop_plot <- plot( num_pop_data[,1], avg_ssms_data[,1], xlab="Number of Populations", ylab="Average Number of SSMs/Population", col=total_ssms_num_pop$cluster)

num_leaves_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_leaves_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
num_leaves_data_init$ssms <- total_ssms_data_init[,1]
total_ssms_num_leaves <- kmeans(num_leaves_data_init, 4, iter.max = 100)
total_ssms_pop_plot <- plot(total_ssms_data[,1], num_leaves_data_init[,1], xlab="Total number of SSMs/tree", ylab="Number of Leaves", col=total_ssms_num_pop$cluster)

max_branching_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_leaves_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
max_branching_data_init$size <- 0
max_branching <- kmeans(max_branching_data_init[,1], 2, iter.max = 100)
max_branching_plot <- plot(max_branching_data_init[,1], max_branching_data_init[,2], xlab="Maximum Branching", ylab="", col=max_branching$cluster)

plot(num_pop_data[,1], num_leaves_data_init[,1], xlab="Number of Populations", ylab="Number of Leaves", main="Relationship between Number of Leaves and Number of Populations", cex.main=1)
# 
# num_pop_data <- read.table("/Users/avasoleimany/phylowgs/matrix_num_pop_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
# num_pop_data$size <- 0
# num_pop_kmeans <- kmeans(num_pop_data, 4, iter.max = 100)
# num_pop_plot <- plot(num_pop_data[,1], num_pop_data[,2], xlab="Number of Populations", yaxt="n", ylab="", col=num_pop_kmeans$cluster)
# 
# 
# avg_ssms_data <- read.table("/Users/avasoleimany/phylowgs/matrix_avg_ssms_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
# avg_ssms_data$size <- 0
# avg_ssms_kmeans <- kmeans(avg_ssms_data, 4, iter.max = 100)
# avg_ssms_plot <- plot(avg_ssms_data[,1], avg_ssms_data[,2], xlab="Average number of SSMS/population", yaxt="n", ylab="", col=avg_ssms_kmeans$cluster)
# 
# total_ssms_data <- read.table("/Users/avasoleimany/phylowgs/matrix_total_ssms_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
# total_ssms_data$size <- 0
# total_ssms_kmeans <- kmeans(total_ssms_data, 4, iter.max = 100)
# total_ssms_plot <- plot(total_ssms_data[,1], total_ssms_data[,2], xlab="Total number of SSMs/tree", yaxt="n", ylab="", col=total_ssms_kmeans$cluster)
# 
# num_pop_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_pop_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
# avg_ssms_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_avg_ssms_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
# num_pop_data_init$ssms <- avg_ssms_data_init[,1]
# avg_ssms_num_pop <- kmeans(num_pop_data_init, 4, iter.max = 100)
# avg_ssms_pop_plot <- plot(avg_ssms_data[,1], num_pop_data[,1], xlab="Average number of SSMs/population", ylab="Number of Populations", col=total_ssms_num_pop$cluster)
# 
# num_leaves_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_leaves_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
# num_leaves_data_init$ssms <- total_ssms_data_init[,1]
# total_ssms_num_leaves <- kmeans(num_leaves_data_init, 4, iter.max = 100)
# total_ssms_pop_plot <- plot(total_ssms_data[,1], num_leaves_data_init[,1], xlab="Total number of SSMs/tree", ylab="Number of Leaves", col=total_ssms_num_pop$cluster)
# 
# max_branching_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_leaves_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
# max_branching_data_init$ssms <- total_ssms_data_init[,1]
# total_ssms_max_branching <- kmeans(max_branching_data_init, 4, iter.max = 100)
# total_ssms_max_branching_plot <- plot(total_ssms_data[,1], max_branching_data_init[,1], xlab="Total number of SSMs/tree", ylab="Maximum Branching", col=total_ssms_num_pop$cluster)
# 
# plot(num_pop_data[,1], num_leaves_data_init[,1], xlab="Number of Populations", ylab="Number of Leaves", main="Relationship between Number of Leaves and Number of Populations", cex.main=1)





