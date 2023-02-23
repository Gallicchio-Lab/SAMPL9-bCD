#!/bin/bash
for sys in ?cd-PMZ1*-*1* ; do
    ( cd ${sys} && bash ./run.sh )
done
