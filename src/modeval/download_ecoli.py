import wget
import os




# URLs of the files to be downloaded
get_precise2_norm = "https://raw.githack.com/SBRG/precise2/master/data/precise2/log_tpm_norm_qc.csv"
get_regulon_db = "https://regulondbdata.ccg.unam.mx//dump/rdb-mongo/regulondb_13.0.zip"

# Get the directory of the current script
script_dir = os.path.dirname(os.path.abspath(__file__))

# Construct the local paths relative to the script directory
rna_seq_data_loc = os.path.join(script_dir, "../../data/RNAseq/log_tpm_norm_qc.csv")
reg_db_loc = os.path.join(script_dir, "../data/ecoli_precise2/regprecise_tf_gene_interactions.txt")

# Perform the downloads
wget.download(get_precise2_norm, rna_seq_data_loc)
wget.download(get_regulon_db, reg_db_loc, )

print(f"Files downloaded successfully and saved to {rna_seq_data_loc} and {reg_db_loc}")
