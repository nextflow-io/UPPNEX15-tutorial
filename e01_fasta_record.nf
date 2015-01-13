#!/usr/bin/env nextflow

/* 
 * The `file` function converts the string path to a file object 
 */
 
my_file = file("$baseDir/data/sample.fa")

/* 
 * Applies the `splitFasta` method to parse the source file 
 * as a FASTA file. 
 */

my_file.splitFasta( record: [id: true, sequence:true] ) { fasta ->
  println fasta.id
} 
