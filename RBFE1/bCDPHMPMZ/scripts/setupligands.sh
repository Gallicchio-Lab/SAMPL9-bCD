#!/bin/bash
ffpath=$HOME/Dropbox/SAMPL9-eglab/FFEngine/ffmol2s
sdfpath=$HOME/Dropbox/SAMPL9-eglab/bCD/ligsdfs

rm PHM*.mol2 PHM*.sdf PHM*.frcmod PHM*.leaprc
rm PMZ*.mol2 PMZ*.sdf PMZ*.frcmod PMZ*.leaprc

for pose in ssS spS ssR spR psS ppS psR ppR ; do
    cp ${ffpath}/PHM0a/vacuum_ucase.mol2 PHM0a${pose}.mol2
    cp ${ffpath}/PHM0a/vacuum_ucase.frcmod PHM0a${pose}-p.frcmod
    cp ${ffpath}/PHM0a/leaprc_header_ucase PHM0a${pose}-p.leaprc
    cp ${sdfpath}/PHM0a${pose}.sdf .


    cp ${ffpath}/PMZ1a/vacuum_ucase.mol2 PMZ1a${pose}.mol2
    cp ${ffpath}/PMZ1a/vacuum_ucase.frcmod PMZ1a${pose}-p.frcmod
    cp ${ffpath}/PMZ1a/leaprc_header_ucase PMZ1a${pose}-p.leaprc
    cp ${sdfpath}/PMZ1a${pose}.sdf .
    
done

python ../scripts/applycoord.py


