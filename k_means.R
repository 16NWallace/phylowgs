num_pop_data <- read.table("/Users/avasoleimany/phylowgs/matrix_num_pop_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
num_pop_data$size <- 0
num_pop_kmeans <- kmeans(num_pop_data, 4, iter.max = 100)
num_pop_plot <- plot(num_pop_data[,1], num_pop_data[,2], xlab="Number of Populations", yaxt="n", ylab="", col=num_pop_kmeans$cluster)


avg_ssms_data <- read.table("/Users/avasoleimany/phylowgs/matrix_avg_ssms_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
avg_ssms_data$size <- 0
avg_ssms_kmeans <- kmeans(avg_ssms_data, 4, iter.max = 100)
avg_ssms_plot <- plot(avg_ssms_data[,1], avg_ssms_data[,2], xlab="Average number of SSMS/population", yaxt="n", ylab="", col=avg_ssms_kmeans$cluster)

total_ssms_data <- read.table("/Users/avasoleimany/phylowgs/matrix_total_ssms_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
total_ssms_data$size <- 0
total_ssms_kmeans <- kmeans(total_ssms_data, 4, iter.max = 100)
total_ssms_plot <- plot(total_ssms_data[,1], total_ssms_data[,2], xlab="Total number of SSMs/tree", yaxt="n", ylab="", col=total_ssms_kmeans$cluster)

num_pop_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_pop_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
total_ssms_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_total_ssms_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
num_pop_data_init$ssms <- total_ssms_data_init[,1]
total_ssms_num_pop <- kmeans(num_pop_data_init, 4, iter.max = 100)
total_ssms_pop_plot <- plot(total_ssms_data[,1], num_pop_data[,1], xlab="Total number of SSMs/tree", ylab="Number of Populations", col=total_ssms_num_pop$cluster)

num_leaves_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_leaves_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
num_leaves_data_init$ssms <- total_ssms_data_init[,1]
total_ssms_num_leaves <- kmeans(num_leaves_data_init, 4, iter.max = 100)
total_ssms_pop_plot <- plot(total_ssms_data[,1], num_leaves_data_init[,1], xlab="Total number of SSMs/tree", ylab="Number of Leaves", col=total_ssms_num_pop$cluster)

max_branching_data_init <- read.table("/Users/avasoleimany/phylowgs/matrix_num_leaves_depth_300.csv", header=FALSE, stringsAsFactors = FALSE)
max_branching_data_init$ssms <- total_ssms_data_init[,1]
total_ssms_max_branching <- kmeans(max_branching_data_init, 4, iter.max = 100)
total_ssms_max_branching_plot <- plot(total_ssms_data[,1], max_branching_data_init[,1], xlab="Total number of SSMs/tree", ylab="Maximum Branching", col=total_ssms_num_pop$cluster)

plot(num_pop_data[,1], num_leaves_data_init[,1], xlab="Number of Populations", ylab="Number of Leaves", main="Relationship between Number of Leaves and Number of Populations", cex.main=1)



