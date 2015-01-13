#!/usr/bin/env nextflow

/* 
 * Basic example showing how to read a multi FASTA file 
 * three sequences at time 
 */

count = 0

my_file = file("$baseDir/data/Homo.prot.250.fa")

my_file.splitFasta( by: 10, limit: 100 ) { 
  println it;
  count++
} 


println "Total fasta splits: $count"
