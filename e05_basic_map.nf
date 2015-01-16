#!/usr/bin/env nextflow

/* 
 * This example shows how concatenate operators
 * 
 * - `from` creates a channel emitting the specified values 
 * - `map` transforms each emitted value applying the specified rule 
 * - `subscribe` will print the resulting values 
 */

Channel
    .from( 1, 2, 3, 4, 5 )
    .map { it * it }
    .subscribe { println it }