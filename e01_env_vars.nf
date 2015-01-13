#!/usr/bin/env nextflow

/* 
 * Environment variables can be accessed directly in the script context 
 */
 
println "Current home: $HOME"
println "Current user: $USER"
println "Current path: $PWD"

/* 
 * In the script are defined implicitly the following variables: 
 * - baseDir: path of the directly where the main script is defined
 * - workDir: path of nextflow scratch directory where intermediate 
 *            result files are stored 
 */ 
 
println "Script dir: $baseDir"
println "Working dir: $workDir"