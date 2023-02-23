#!/bin/bash
ffpath=$HOME/Dropbox/SAMPL9-eglab/FFEngine/ffmol2s
sdfpath=$HOME/Dropbox/SAMPL9-eglab/mCD/ligsdfs
pose=spS

rm *.mol2 *.sdf *frcmod *.leaprc

for mol in CPZ0a CPZ1a PMT0a PMT1a PMZ0a PMZ1a TDZNR0a TDZNR1a TDZNS0a TDZNS1a TFP0a TFP1a TFP1b ; do
    cp ${ffpath}/${mol}/vacuum_ucase.mol2 ${mol}${pose}.mol2
    cp ${ffpath}/${mol}/vacuum_ucase.frcmod ${mol}${pose}-p.frcmod
    cp ${ffpath}/${mol}/leaprc_header_ucase ${mol}${pose}-p.leaprc
    cp ${sdfpath}/${mol}${pose}.sdf .
done

python ../scripts/applycoord.py

for mol in CPZ0a CPZ1a PMT0a PMT1a PMZ0a PMZ1a TDZNR0a TDZNR1a TDZNS0a TDZNS1a TFP0a TFP1a TFP1b ; do
    cp ${mol}${pose}.mol2 ${mol}${pose}-p.mol2 
done
