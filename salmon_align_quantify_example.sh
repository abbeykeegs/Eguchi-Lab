module load salmon/1.8.0

INPATH=/RNASeq/Full_Data/DMD_Empty_1_1/ ##input to fastq files
BASENAME=DMD19_Empty_1 ##header of the fastq files
OUTDIR=/RNASeq/Full_Data/DMD_Empty_1_1/Salmon_Output

IN_FQ1=${INPATH}DMD19Empty_1_1.fq.gz
IN_FQ2=${INPATH}DMD19Empty_1_2.fq.gz

SALMON_IDX=/RNASeq/Salmon/Human/salmon_index/ ##directory containing salmon index
GTF_FILE=/RNASeq/Salmon/Human/gencode.v44.tx2gene.tsv ##directory with gtf files
THREADS=8

OUT_FILE_DONE=${BASENAME}.SalmonQuant.done

mkdir -p $OUTDIR
cd $OUTDIR || exit

echo -e "Starting Salmon Quantification\n"

if [ ! -f $OUT_FILE_DONE ]; then
    salmon quant \
        -i $SALMON_IDX \
        -o ${BASENAME}_SalmonOut \
        -l A \
        -p $THREADS \
        -1 $IN_FQ1 \
        -2 $IN_FQ2 \
        -g $GTF_FILE \
        --validateMappings \
        && touch $OUT_FILE_DONE
fi

echo -e "Script Complete \n\n"
