#!/bin/bash
chmod u+x batch_FASTA_nt.sh
#___________________________________________________________________________________________

##blast+ executable files must be in Program files. See IT admin for admin access to download/move files to program files.
	#ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/
		#file name: "...win64.exe"
##download .tar.gz file for required database (16S microbial, etc.) from ftp://ftp.ncbi.nlm.nih.gov/blast/db
	## documentaion for other database files are at file:///C:/Users/fmartinez/Downloads/blastdb.html
	## to unzip tar.gz file open console and type "tar -zxfv file.tar.gz"

#___________________________________________________________________________________________

##save all files in a folder within your own personal drive (P:)

##cd to directory containing batch_FASTA.sh code, if not already in PATH.
##moves all FASTAs into one folder

echo 'Drag parent directory containing 16S FASTAs for blastn query'
read fasta_dir
alias batch_FASTA=$fasta_dir

#___________________________________________________________________________________________

mkdir $fasta_dir/FASTA_files
find $fasta_dir -iname '*.fasta' -exec cp {} $fasta_dir/FASTA_files \; 2> /dev/null
	#2> /dev/null suppress shell script error message from cp FASTA in main directory to another file in a subdirectory
echo -e '\n\nFASTAs ready for analysis\n\n'


#___________________________________________________________________________________________

#find 16SMicrobial files in personal drive (P:)
#DB16S=$(find /p/ -type d -name '16SMicrobial')


##looping FASTA files through blastn command
#echo 'enter number of results to print to report'
#read $num_descript
#echo 'enter number of alignments to include in report'
#read $num_align
#echo 'Select default sort: (0) evalue, (1) bit score, (2) total score, (3) percent identity, (4) query coverage'
#read $sortval

for f in $fasta_dir/FASTA_files/*.fasta; do
	echo 'Processing' $(basename $f) '...';
	b=$(basename -s .fasta $f);
	'C:\Program Files\NCBI\blast-2.9.0+\bin\blastn' -query "$f" -db nt -outfmt 0 -out $fasta_dir/FASTA_files/$b.doc -num_descriptions 100 -num_alignments 10 -sorthits 3 -remote -html;
	echo -e '16S BLAST search completed\n';
done

echo 'Results printed to' $fasta_dir/FASTA_files
