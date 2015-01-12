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
        .map { pair1, pair2 -> [ pair1[1], pair2[1] ] }

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
	set file(read1), file(read2) from read_pairs

    output:
    file "tophat_out/accepted_hits.bam" into bam

    """
    tophat2 genome.index ${read1} ${read2}
    """
}


process cufflinks {
    input:
    file bam
    
    output:
    file 'transcripts.gtf' into transcripts

    """
    cufflinks ${bam}

    """
}


transcripts.subscribe { println it }
