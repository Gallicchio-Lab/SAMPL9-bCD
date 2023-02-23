#!/bin/bash

for pair in PMZ1apsR-CPZ1apsR PMZ1apsR-PMT1apsR PMZ1apsR-TDZNR1apsR PMZ1apsR-TDZNS1apsR PMZ1apsR-TFP1apsR PMZ1apsR-TFP1bpsR  ; do
    ( cd mCDpsR-${pair} && res=`./analyze.sh 250` && echo "$pair $res")
done
