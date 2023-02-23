#!/bin/bash

rcpt=mcd
for lig in g1p g1s  ; do
    ( cd ${rcpt}-${lig} && bash ./run.sh )
done
