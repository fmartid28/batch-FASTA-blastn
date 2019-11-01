###program for looping through fasta files and running multiple individual blasts remotely###

----------------------------------------------------------------------------------------------------------------------------------------------------------

##blastn located at C:\Program Files\NCBI\blast-2.9.0+\bin

##download: Git bash app for windows (or mac for mac) and NCBI blast+ win64.tar.gz (or mac os version for mac) executable files for windows from  ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/
##download .tar.gz file for required database (16S microbial, etc.) from ftp://ftp.ncbi.nlm.nih.gov/blast/db
	## documentaion for other database files are at file:///C:/Users/fmartinez/Downloads/blastdb.html
	## to open tar.gz file open console and type "tar -zxfv file.tar.gz"


----------------------------------------------------------------------------------------------------------------------------------------------------------

#copy all fastas from one directory (and its subdirectories) to another directory
	#set working directory to parent directory containing the subdirectories of interest
$ find . -name "*.fasta" -exec cp --target-directory='/c/Users/fmartinez/Desktop/blast program/A_A fastas' '{}' +


----------------------------------------------------------------------------------------------------------------------------------------------------------

#set working directory to directory containing the tar.gz file

#unzip 16SMicrobial.tar.gz file
$ tar -zxfv 16SMicrobial.tar.gz

#create new folder and move the tar.gz file and all of the unzipped files into it
#set working directory to directory containing unzipped database files
$ cd '/c/Users/fmartinez/Desktop/blast program/16MicrobialdbFiles'

#use script below to run a BLAST query to the 16SMicrobial database for a fasta file containing one or more microbial sequences
	#each sequence has two lines: first line contains the name i.e. ">name", and second line containing the sequence on one string
$'/c/Program Files/NCBI/blast-2.9.0+/bin/blastn' -query '/c/Users/fmartinez/Desktop/blast program/16s_library.fasta' -db 16SMicrobial -out '/c/Users/fmartinez/Desktop/blast program/16sout.doc' -num_descriptions 5 -num_alignments 2


----------------------------------------------------------------------------------------------------------------------------------------------------------


#loop to individually run all files IN A GIVEN DIRECTORY through blastn script

for f in /Volumes/FM\ USB/16s\ stuff/A_A\ fastas/*.fasta; do
b=$(basename -s .fasta $f);
./ncbi-blast-2.9.0+/bin/blastn -query "$f" -db 16SMicrobial -out "/Volumes/FM USB/16s stuff/A_A fastas/"$b.doc -num_descriptions 5 -num_alignments 2;
done   

### change all doc files font to 6

##script below is for mac only
textutil -convert doc -font 'Courier New' -fontsize 6 /Volumes/FM\ USB/16s\ stuff/A_A\ fastas/*.doc












