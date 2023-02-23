#!/bin/bash

#for pair in PMZ1apsS-CPZ1apsS PMZ1apsS-PMT1apsS PMZ1apsS-TDZNR1apsS PMZ1apsS-TDZNS1apsS PMZ1apsS-TFP1apsS PMZ1apsS-TFP1bpsS  ; do
for pair in PMZ1apsS-CPZ1apsS PMZ1apsS-TDZNR1apsS PMZ1apsS-TDZNS1apsS PMZ1apsS-TFP1apsS PMZ1apsS-TFP1bpsS  ; do
    ( cd bCDpsS-${pair} && bash ./run.sh )
done
