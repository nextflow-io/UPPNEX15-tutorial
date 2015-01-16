#!/usr/bin/env nextflow

/* 
 * This example shows how concatenate operators
 * 
 * - `from` creates a channel emitting two (or more) strings
 * - `map` transforms each string to a list of words
 * - `flatMap` will emits each entry in the list as a sole emission
 * - `map` will transform each word to a pair containing the word itself and its length  
 * - `subscribe` finally will print the result (note the argument expansion)
 */

Channel
    .from( "Hello world", "it's a beautiful day" )
    .map { it.tokenize() }
    .flatMap()
    .map { [ it, it.size() ] }
    .subscribe { word, size -> 
                    println "word '$word' contains $size characters" 
                }