#!/bin/bash

for pair in g1s-PHM0aspS g1s-PHM0assS g1s-PHM0aspR g1s-PHM0assR g1p-PHM0appS g1p-PHM0apsS g1p-PHM0appR g1p-PHM0apsR  ; do
    ( cd mcd-${pair} && res=`./analyze.sh 150` && echo "$pair $res")
done
