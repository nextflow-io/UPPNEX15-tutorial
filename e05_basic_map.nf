#!/usr/bin/env nextflow

/* 
 * This example shows how concatenate operators
 */

Channel
    .from( 1, 2, 3, 4, 5 )
    .map { it * it }
    .subscribe { println it }