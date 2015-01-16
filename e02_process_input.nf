#!/usr/bin/env nextflow

NR = file("$baseDir/blast-db/pdb/tiny")
proteins = file("$baseDir/data/sample.fa")


/* 
 * Executes a Blast search with using the `protein` file
 */
 
process blastJob {

  input:
  file 'query.fa' from proteins

  """ 
  blastp -query query.fa -db $NR -outfmt 6
  """

}
