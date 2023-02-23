#!/bin/bash

for pair in PMZ1appR-CPZ1appR PMZ1appR-PMT1appR PMZ1appR-TDZNR1appR PMZ1appR-TDZNS1appR PMZ1appR-TFP1appR PMZ1appR-TFP1bppR  ; do
    ( cd mCDppR-${pair} && res=`./analyze.sh 250` && echo "$pair $res")
done
