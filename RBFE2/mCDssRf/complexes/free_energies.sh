#!/bin/bash

for pair in PMZ1assR-CPZ1assR PMZ1assR-PMT1assR PMZ1assR-TDZNR1assR PMZ1assR-TDZNS1assR PMZ1assR-TFP1assR PMZ1assR-TFP1bssR  ; do
    ( cd mCDssR-${pair} && res=`./analyze.sh 250` && echo "$pair $res")
done
