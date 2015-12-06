num_pop_data <- read.table("/Users/avasoleimany/phylowgs/matrix_num_pop_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
num_pop_data$size <- 0
num_pop_kmeans <- kmeans(num_pop_data, 4, iter.max = 100)
num_pop_plot <- plot(num_pop_data[,1], num_pop_data[,2], xlab="Inferred Number of Populations", yaxt="n", ylab="", col=num_pop_kmeans$cluster)
num_pop_dist <- dist(avg_ssms_data[,1], method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
num_pop_hierarchical <- hclust(num_pop_dist, method = "complete", members = NULL)
num_pop_hierarchical_plot <- plot(num_pop_hierarchical, xlab = "Inferred Number of Populations", hang = 0.1, check = TRUE,
                                   axes = TRUE, frame.plot = FALSE, ann = TRUE, labels=FALSE,
                                   sub = NULL, main = NULL, ylab = "Height")

avg_ssms_data <- read.table("/Users/avasoleimany/phylowgs/matrix_avg_ssms_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
avg_ssms_data$size <- 0
avg_ssms_dist <- dist(avg_ssms_data[,1], method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
avg_ssms_hierarchical <- hclust(avg_ssms_dist, method = "complete", members = NULL)
avg_ssms_hierarchical_plot <- plot(avg_ssms_hierarchical, xlab = "Average number of SSMs/population", hang = 0.1, check = TRUE,
     axes = TRUE, frame.plot = FALSE, ann = TRUE, labels=FALSE,
     sub = NULL, main = NULL, ylab = "Height")

avg_cnvs_data <- read.table("/Users/avasoleimany/phylowgs/matrix_avg_cnvs_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
avg_cnvs_data$ssms <- avg_ssms_data[,1]
avg_ssms_cnvs_kmeans <- kmeans(avg_cnvs_data, 6, iter.max = 100)
avg_ssms_cnvs_plot <- plot(avg_cnvs_data[,2], avg_cnvs_data[,1], xlab="Average number of SSMs/population", ylab="Average number of CNVs/population", col=avg_ssms_cnvs_kmeans$cluster)

max_branching_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_leaves_depth_300_v2.csv", header=FALSE, stringsAsFactors = FALSE)
max_branching_data_init$size <- 0
max_branching <- kmeans(max_branching_data_init[,1], 2, iter.max = 100)
max_branching_plot <- plot(max_branching_data_init[,1], max_branching_data_init[,2], xlab="Maximum Branching", yaxt="n", ylab="", col=max_branching$cluster)
max_branching_dist <- dist(max_branching_data_init[,1], method = "euclidean", diag = FALSE, upper = FALSE, p = 2)
max_branching_hierarchical <- hclust(max_branching_dist, method = "complete", members = NULL)
max_branching_hierarchical_plot <- plot(max_branching_hierarchical, xlab = "Maximum Branching", hang = 0.1, check = TRUE,
                                  axes = TRUE, frame.plot = FALSE, ann = TRUE, labels=FALSE,
                                  sub = NULL, main = NULL, ylab = "Height")



