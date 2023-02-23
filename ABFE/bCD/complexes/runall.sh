#!/bin/bash

rcpt=bcd
for lig in g1s g1p ; do
    ( cd ${rcpt}-${lig} && bash ./run.sh )
done
