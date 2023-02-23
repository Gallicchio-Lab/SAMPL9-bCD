#!/bin/bash

for pair in PMZ1aspR-CPZ1aspR PMZ1aspR-PMT1aspR PMZ1aspR-TDZNR1aspR PMZ1aspR-TDZNS1aspR PMZ1aspR-TFP1aspR PMZ1aspR-TFP1bspR  ; do
    ( cd mCDspR-${pair} && res=`./analyze.sh 250` && echo "$pair $res")
done
