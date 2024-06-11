#!/usr/bin/env Rscript

# Load necessary libraries
library(tidyverse)
library(GENIE3)
library(optparse)

# Define command line options
option_list <- list(
  make_option(c("-r", "--regs"), type = "character", default = NULL,
              help = "Path to regulators CSV file", metavar = "character"),
  make_option(c("-c", "--counts"), type = "character", default = NULL,
              help = "Path to counts CSV file", metavar = "character"),
  make_option(c("-o", "--output"), type = "character", default = NULL,
              help = "Path to output CSV file (optional, generated if not provided)", metavar = "character"),
  make_option(c("-n", "--cores"), type = "integer", default = 1,
              help = "Number of cores to use", metavar = "integer"),
  make_option(c("-t", "--targets"), type = "character", default = NULL,
              help = "Targets for GENIE3", metavar = "character"),
  make_option(c("-m", "--treeMethod"), type = "character", default = "RF",
              help = "Tree method to use", metavar = "character"),
  make_option(c("-k", "--K"), type = "character", default = "sqrt",
              help = "Number of candidate regulators randomly selected at each tree node", metavar = "character"),
  make_option(c("-T", "--nTrees"), type = "integer", default = 1000,
              help = "Number of trees in an ensemble for GENIE3", metavar = "integer"),
  make_option(c("--returnMatrix"), action = "store_true", default = TRUE,
              help = "Return importance matrix (default: TRUE)"),
  make_option(c("--verbose"), action = "store_true", default = FALSE,
              help = "Print progress report (default: FALSE)")
)

# Parse command line options
opt_parser <- OptionParser(option_list = option_list)
opt <- parse_args(opt_parser)

# Set variables from parsed options
regs <- opt$regs
counts <- opt$counts
output <- opt$output
cores <- opt$cores
targets <- opt$targets
treeMethod <- opt$treeMethod
K <- opt$K
nTrees <- opt$nTrees
returnMatrix <- opt$returnMatrix
verbose <- opt$verbose
seed <- 5

# Set seed for reproducibility
set.seed(seed)

# Load the files
t_counts <- read.csv(counts)
if (!is.null(regs)) {
  raw_regs <- read.csv(regs)
}

# Prepare the counts matrix
ncounts <- t_counts %>%
  select(-"Geneid")

expmatr <- as.matrix(ncounts)
colnames(expmatr) <- colnames(ncounts)
rownames(expmatr) <- t_counts$Geneid

# Run GENIE3
if (!is.null(regs)) {
  regulators <- raw_regs[, 1]
  num_regulators <- length(regulators)
} else {
  regulators <- NULL
  num_regulators <- 0
}

results <- GENIE3(
  exprMatrix = expmatr,
  regulators = regulators,
  targets = targets,
  treeMethod = treeMethod,
  K = K,
  nTrees = nTrees,
  nCores = cores,
  returnMatrix = returnMatrix,
  verbose = verbose
)
linklist <- getLinkList(results)

# Generate file name if not provided
if (is.null(output)) {
  today <- Sys.Date()
  output <- paste0("GENIE3_", seed, "_", treeMethod, "_K", K, "_nTrees", nTrees, "_nRegs", num_regulators, "_", today, ".csv")
}

# Save results to the specified output file
write.csv(linklist, output)

# Print completion message
cat("Results saved to", output, "\n")
