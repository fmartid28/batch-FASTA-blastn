#!/bin/bash
chmod u+x batch_FASTA.sh

##cd to directory containing batch_FASTA.sh code, if not already in PATH.
##moves all FASTAs for 16S querying into one folder
echo 'Drag directory containing subdirectories with FASTAs of interest'
read fasta_dir
alias batch_FASTA=$fasta_dir
mkdir $fasta_dir/FASTA_files
find $fasta_dir -iname '*.fasta' -exec cp {} $fasta_dir/FASTA_files \; 2> /dev/null
	#2> /dev/null suppress shell script error message from cp FASTA in main directory to another file in a subdirectory
echo -e '\n\nFASTAs ready for analysis\n\n'

##on mac make sure blastn file is in same directory as 16S files
echo 'Drag folder containing 16SMicrobial database files'
read dir_16S

##looping FASTA files through blastn query command
##for blastn to work, make sure 16SMicrobial DB is in 'current' directory. In loop below, it is made the current directory of the subshell by the alias command
for f in $fasta_dir/FASTA_files/*.fasta; do
	alias batch_FASTA=$dir_16S;
	echo 'Processing' $(basename $f) '...';
	b=$(basename -s .fasta $f);
	'C:\Program Files\NCBI\blast-2.9.0+\bin\blastn' -query "$f" -db $dir_16S/16SMicrobial  -out $fasta_dir/FASTA_files/$b.doc -num_descriptions 5 -num_alignments 2;
	echo -e '16S BLAST search completed\n';
done