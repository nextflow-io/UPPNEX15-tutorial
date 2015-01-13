#!/usr/bin/env nextflow

/* 
 * This example shows how concatenate operators
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