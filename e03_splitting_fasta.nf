#!/usr/bin/env nextflow

/* 
 * Define the pipeline parameters
 */
params.query = "$HOME/ACGT14-tutorial/data/sample.fa"
params.chunkSize = 10
params.db = "$HOME/blast-db/pdb/pdb"

DB = file(params.db)
fasta = file(params.query)
seq = Channel.from(fasta).splitFasta(by: params.chunkSize)

/*
 * Execute a BLAST job for each chunk for the provided sequences
 */
process blast {
    input:
    file 'seq.fa' from seq

    output:
    file 'out' into blast_result

    """
    blastp -db $DB -query seq.fa -outfmt 6 > out
    """
}
