#!/bin/bash
chmod u+x batch_FASTA.sh


##moves all FASTAs for 16S querying into one folder
echo 'Drag the main directory containing subdirectories with FASTAs of interest'
read fasta_dir
alias batch_FASTA=$fasta_dir
echo 'Create a new folder to contain FASTA files and results and drag it here'
read fasta_files
find $fasta_dir -iname '*.fasta' -exec cp {} $fasta_files \;


#loops query on each FASTA and produces a result for each FASTA
#make sure blastn file is in same directory as 16S files
echo drag folder containing 16SMicrobial db files
read dir_16S
alias batch_FASTA=$dir_16S

#actual l"oop code"
for f in $fasta_files/*.fasta; do
	echo $f;
	b=$(basename -s .fasta $f);
	"$dir_16S"/ncbi-blast-2.9.0+/bin/blastn -query "$f" -db 16SMicrobial -out "$fasta_files"/$b.doc -num_descriptions 5 -num_alignments 3;
done


