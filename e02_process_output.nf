#!/usr/bin/env nextflow

NR = file("$baseDir/blast-db/pdb/tiny")
proteins = file("$baseDir/data/sample.fa")

process blastJob {

  input:
  file 'query.fa' from proteins

  output: 
  file 'out.txt' into blast_result

   """ 
   blastp -query query.fa -db $NR -outfmt 6 > out.txt
   """

}

blast_result.subscribe { println it.text }

