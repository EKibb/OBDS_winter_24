#!/bin/bash
##########################################################################
## A script template for submitting batch jobs. To submit a batch job, 
## please type
##
##    sbatch myprog.sh
##
## Please note that anything after the characters "#SBATCH" on a line
## will be treated as a Slurm option.
##########################################################################

## Specify a partition. Check available partitions using sinfo Slurm command.
#SBATCH --partition=long

## The following line will send an email notification to your registered email
## address when the job ends or fails.
#SBATCH --mail-type=END,FAIL

## Specify the amount of memory that your job needs. This is for the whole job.
## Asking for much more memory than needed will mean that it takes longer to
## start when the cluster is busy.
#SBATCH --mem=10G

## Specify the number of CPU cores that your job can use. This is only relevant for
## jobs which are able to take advantage of additional CPU cores. Asking for more
## cores than your job can use will mean that it takes longer to start when the
## cluster is busy.
#SBATCH --ntasks=4

## Specify the maximum amount of time that your job will need to run. Asking for
## the correct amount of time can help to get your job to start quicker. Time is
## specified as DAYS-HOURS:MINUTES:SECONDS. This example is one day.
#SBATCH --time=1-00:00:00

## Provide file name (files will be saved in directory where job was ran) or path
## to capture the terminal output and save any error messages. This is very useful
## if you have problems and need to ask for help.
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err

# -p so no error if directory exists, make parent directories if needed
mkdir -p /tmp/$USER

# Load modules as required
#module load R-base/4.3.0

#  Viewing, sorting & indexing  results sam file after mapping - generates bam file
samtools view -b /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086.sam > /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086.bam \
# Sort the bam file, using -@ short option to specify no. of threads
samtools sort -@ 12 threads /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086.bam > /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086_sorted.bam
# Index sorted .bam file
samtools index /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086_sorted.bam
# Output the FlagStats
samtools flagstat /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086_sorted.bam > /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086_sorted.flagstat
# Output the IDXStats
samtools idxstats  /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086_sorted.bam > /project/oues0566/1_linux/rnaseq/4_outputs/2_mapping/ERR1755086_sorted.idxstats

