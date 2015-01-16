#!/usr/bin/env nextflow

/* 
 * This example shows how concatenate operators
 * 
 * - `fromPath` creates a channel emitting the files matching 
 *   the path matcher specified with `params.in`
 * - `splitFasta` parse them as FASTA files a creates a record 
 *   for each sequence
 * - `filter` excludes all the ones whose ID does not match the `ENSP0` prefix 
 * - `count` return the number of sequences matching the filter 
 * - `subscribe` will print the count value      
 */

params.in = "$baseDir/data/Homo.prot.250.fa"

Channel
     .fromPath(params.in)
     .splitFasta( record: [id: true, seqString: true ])
     .filter { record -> 
         record.id =~ /^ENSP0.*/ 
     }
     .count()
     .subscribe { println it }