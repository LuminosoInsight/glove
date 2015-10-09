#!/bin/bash

make

CORPUS=$1
PROCESSED_CORPUS="$CORPUS.tokenized"
VOCAB_FILE=vocab.txt
COOCCURRENCE_FILE=cooccurrence.bin
COOCCURRENCE_SHUF_FILE=cooccurrence.shuf.bin
SAVE_FILE=vectors
LABEL_FILE=labels.txt
VERBOSE=2
MEMORY=16
BINARY=2

VOCAB_MIN_COUNT=5
VECTOR_SIZE=300
MAX_ITER=25
WINDOW_SIZE=10

ipython tokenize.py < $CORPUS > $PROCESSED_CORPUS && \
./vocab_count -min-count $VOCAB_MIN_COUNT -verbose $VERBOSE < $PROCESSED_CORPUS > $VOCAB_FILE && \
./cooccur -memory $MEMORY -vocab-file $VOCAB_FILE -verbose $VERBOSE -window-size $WINDOW_SIZE < $PROCESSED_CORPUS > $COOCCURRENCE_FILE && \
./shuffle -memory $MEMORY -verbose $VERBOSE < $COOCCURRENCE_FILE > $COOCCURRENCE_SHUF_FILE && \
./glove -save-file $SAVE_FILE -input-file $COOCCURRENCE_SHUF_FILE -iter $MAX_ITER -vector-size $VECTOR_SIZE -binary $BINARY -vocab-file $VOCAB_FILE -verbose $VERBOSE && \
ipython convert.py $VECTOR_SIZE "$SAVE_FILE.bin" $SAVE_FILE && \
cut -d' ' -f1 $VOCAB_FILE > $LABEL_FILE
