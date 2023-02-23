#!/bin/bash

for pair in PHM0aspS-PMZ1aspS PHM0assS-PMZ1assS PHM0aspR-PMZ1aspR PHM0assR-PMZ1assR PHM0appS-PMZ1appS PHM0apsS-PMZ1apsS PHM0appR-PMZ1appR PHM0apsR-PMZ1apsR  ; do
    ( cd bcd-${pair} && res=`./analyze.sh 100` && echo "$pair $res")
done
