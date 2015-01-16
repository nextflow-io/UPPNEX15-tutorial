#!/usr/bin/env nextflow

NR = file("$baseDir/blast-db/pdb/tiny")
proteins = file("$baseDir/data/sample.fa")

/*
 * Executes a Blast search with using the `protein` file.
 * The output is sent over the `result` channel 
 */

process blastJob {

  input:
  file 'query.fa' from proteins

  output: 
  file 'out.txt' into blast_result

   """ 
   blastp -query query.fa -db $NR -outfmt 6 > out.txt
   """

}

/* 
 * The `subscribe` operator is triggered when the `blast_result`
 * emits the output produced by the above process, printing 
 * the blast result
 */
blast_result.subscribe { println it.text }

