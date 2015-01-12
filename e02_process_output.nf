#!/usr/bin/env nextflow

NR = file("$HOME/blast-db/pdb/pdb")
my_file = file("$HOME/ACGT14-tutorial/data/sample.fa")
proteins = Channel.from(my_file)

process blastJob {

  input:
  file 'query.fa' from proteins

  output: 
  file 'out.txt' into blast_result

   """ 
   blastp -query query.fa -db $NR -outfmt 6 > out.txt
   """

}

blast_result.subscribe {
   println it
}

