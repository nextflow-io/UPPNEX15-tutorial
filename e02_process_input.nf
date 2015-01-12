#!/usr/bin/env nextflow

NR = file("$HOME/blast-db/pdb/pdb")
my_file = file("$HOME/ACGT14-tutorial/data/sample.fa")
proteins = Channel.from(my_file)

process blastJob {

  input:
  file 'query.fa' from proteins

  """ 
  blastp -query query.fa -db $NR -outfmt 6
  """

}
