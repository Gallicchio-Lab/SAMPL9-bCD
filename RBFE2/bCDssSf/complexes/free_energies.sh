#!/bin/bash

for pair in PMZ1assS-CPZ1assS PMZ1assS-PMT1assS PMZ1assS-TDZNR1assS PMZ1assS-TDZNS1assS PMZ1assS-TFP1assS PMZ1assS-TFP1bssS  ; do
    ( cd bCDssS-${pair} && res=`./analyze.sh 250` && echo "$pair $res")
done
