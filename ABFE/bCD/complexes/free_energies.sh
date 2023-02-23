#!/bin/bash

rcpt=bcd
for lig in g1s g1p ; do
    ( cd ${rcpt}-${lig} && res=`./analyze.sh 450` && echo "${rcpt}-${lig} ${res}")
done
