#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd $SCRIPT_DIR

GET_ANNOTATION="https://raw.githack.com/SBRG/precise2/master/data/precise2/gene_info.csv"
GET_PRECISE2="https://raw.githack.com/SBRG/precise2/master/data/precise2/log_tpm_norm_qc.csv"
GET_REGULON_DB=https://regulondb.ccg.unam.mx/datasets/browser/RDBECOLIDLF00005

# Construct the local paths relative to the script directory
ECOLI_ANN="../../data/RNAseq/annotation.csv"
RNA_SEQ_DATA_LOC="../../data/RNAseq/log_tpm_norm_qc.csv"
REG_DB_LOC="../../data/ecoli_precise2/regprecise_tf_gene_interactions.txt"

#wget -O $ECOLI_ANN $GET_ANNOTATION
#wget -O $RNA_SEQ_DATA_LOC $GET_PRECISE2
wget -O $REG_DB_LOC $GET_REGULON_DB

https://regulondb.ccg.unam.mx/graphql