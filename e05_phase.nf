#!/usr/bin/env nextflow

/* 
 * This example shows how join to channels
 * 
 * It creates two channels that emits a pairs. The first entry in the pair 
 * represent the language identifier and the second a word in that 
 * language. 
 * 
 * Then, the phase operator synchronise the emission of the channel creating a new pair 
 * containing the words having the same lang identifier (the first element) 
 */
 
foo = Channel.from( tuple('sv', 'värld'), tuple('es', 'mundo'), tuple('en', 'world') )
bar = Channel.from( tuple('en', 'Hello'), tuple('es', 'Hola'), tuple('sv', 'Hallå') )


bar.phase(foo).subscribe { first, second -> 
                                println "lang: ${first[0]} -> ${first[1]} ${second[1]}" 
                            }