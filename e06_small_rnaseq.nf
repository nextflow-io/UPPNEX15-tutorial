params.pair1 = "$HOME/ACGT14-tutorial/data/ggal/*_1.fq" 
params.pair2 = "$HOME/ACGT14-tutorial/data/ggal/*_2.fq"
params.genome = "$HOME/ACGT14-tutorial/data/ggal/ggal_1_48850000_49020000.Ggal71.500bpflank.fa"

// emit all files ending with _1 suffix and map to pair containing the common name
reads1 = Channel
    .fromPath( params.pair1 ) 
    .map {  path -> [ path.baseName[0..-2], path ] } 
 
// do the same for _2   
reads2 = Channel
    .fromPath( params.pair2 ) 
    .map {  path -> [ path.baseName[0..-2], path ] } 
    
// match the pairs on two channels having the same 'key'
// and emit a new pair containing the expected files
read_pairs = reads1
        .phase(reads2)
        .map { pair1, pair2 -> [ pair1[0], pair1[1], pair2[1] ] }

genome_file = file(params.genome)


process buildIndex {
    input:
    file genome_file
    
    output:
    file 'genome.index*' into genome_index
      
    """
    bowtie2-build ${genome_file} genome.index
    """

}


process mapping {
    
    input:
    file genome_file
    file genome_index from genome_index.first()
	set pair_id, file(read1), file(read2) from read_pairs

    output:
    set pair_id, "tophat_out/accepted_hits.bam" into bam

    """
    tophat2 genome.index ${read1} ${read2}
    """
}


process cufflinks {
    input:
    set pair_id, bam_file from bam
    
    output:
    set pair_id, 'transcripts.gtf' into transcripts

    """
    cufflinks ${bam_file}
    """
}


transcripts
  .collectFile() { 
     def result = []
     result << "${it[0]}transcript"
     result << it[1]
     return result
   }
  .subscribe { println it }
