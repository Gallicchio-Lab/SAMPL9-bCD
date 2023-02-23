ffpath=$HOME/Dropbox/SAMPL9-eglab/FFEngine/ffmol2s
pose=psR

rm *.mol2 *.frcmod *.leaprc

for mol in CPZ1a PMT1a PMZ1a TDZNR1a TDZNS1a TFP1a TFP1b ; do
    cp ${ffpath}/${mol}/vacuum_ucase.mol2 ${mol}${pose}.mol2
    python ../scripts/applycoord_from_sdf.py ${mol}${pose}.mol2 ${mol}${pose}.sdf > ${mol}${pose}-p.mol2
    cp ${ffpath}/${mol}/vacuum_ucase.frcmod ${mol}${pose}-p.frcmod
    cp ${ffpath}/${mol}/leaprc_header_ucase ${mol}${pose}-p.leaprc
done
