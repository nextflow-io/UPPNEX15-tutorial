#!/usr/bin/env nextflow
 
/* 
 * 
 * 
 * Try to run this example by entering the following command line: 
 * 
 *   nextflow run --query data/prot_\*.fa
 * 
 * It will execute a blast search for each file that matches the 
 * the wildcard path matcher 
 * 
 */
 
/* 
 * Define the pipeline default parameters. 
 */  
params.query = "$baseDir/data/sample.fa"
params.chunkSize = 10
params.db = "$baseDir/blast-db/pdb/tiny"
params.out = 'blast_result.txt'

/* 
 * the path where the BLAST DB is located 
 */
 
db = file(params.db)

/* 
 * A channel emitting fasta chunks
 */

seq = Channel
        .fromPath(params.query)
        .splitFasta(by: params.chunkSize)


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

/* 
 * Collect all the outputs produced by the `blast` process
 * executions to a single file, whose name is defined by  
 * the `params.out` parameters
 */
 
blast_result
  .collectFile(name: params.out)
  .subscribe {  
     println "Result saved to file: $it"
   }
