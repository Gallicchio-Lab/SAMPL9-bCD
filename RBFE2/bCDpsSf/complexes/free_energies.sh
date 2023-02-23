#!/bin/bash

for pair in PMZ1apsS-CPZ1apsS PMZ1apsS-PMT1apsS PMZ1apsS-TDZNR1apsS PMZ1apsS-TDZNS1apsS PMZ1apsS-TFP1apsS PMZ1apsS-TFP1bpsS  ; do
    ( cd bCDpsS-${pair} && res=`./analyze.sh 250` && echo "$pair $res")
done
