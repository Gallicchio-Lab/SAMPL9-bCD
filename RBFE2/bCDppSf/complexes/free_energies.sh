#!/bin/bash

for pair in PMZ1appS-CPZ1appS PMZ1appS-PMT1appS PMZ1appS-TDZNR1appS PMZ1appS-TDZNS1appS PMZ1appS-TFP1appS PMZ1appS-TFP1bppS  ; do
    ( cd bCDppS-${pair} && res=`./analyze.sh 250` && echo "$pair $res")
done
