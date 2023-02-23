#!/bin/bash

for pair in PMZ1aspS-CPZ1aspS PMZ1aspS-PMT1aspS PMZ1aspS-TDZNR1aspS PMZ1aspS-TDZNS1aspS PMZ1aspS-TFP1aspS PMZ1aspS-TFP1bspS  ; do
    ( cd mCDspS-${pair} && res=`./analyze.sh 250` && echo "$pair $res")
done
