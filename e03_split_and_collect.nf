#!/usr/bin/env nextflow

/* 
 * Define the pipeline parameters
 */
 
params.query = "$baseDir/data/sample.fa"
params.chunkSize = 10
params.db = "$baseDir/blast-db/pdb/tiny"
params.out = 'blast_result.txt'

db = file(params.db)
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
    blastp -db $db -query seq.fa -outfmt 6 > out
    """
}

blast_result
  .collectFile(name: params.out)
  .subscribe {  
     println "Result saved to file: $it"
   }
