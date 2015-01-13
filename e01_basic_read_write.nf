#!/usr/bin/env nextflow
 
/*  
 * Basic example showing how read and write a file content 
 */ 
 
my_file = file("$baseDir/data/sample.fa")
print my_file.text

/* 
 * In order to create a file simply assign a value to the 
 * `text` property  
 */ 
 
new_file = file('my_file')
new_file.text = 'Hello world!\n'

/* 
 * The left shift operator append a string a file
 */

new_file << 'Append a new line\n'