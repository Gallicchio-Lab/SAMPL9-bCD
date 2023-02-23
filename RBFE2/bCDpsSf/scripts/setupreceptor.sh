ffpath=$HOME/Dropbox/SAMPL9-eglab/FFEngine/ffmol2s
pose=psS

rm *.mol2 *.frcmod *.leaprc

for mol in bCD ; do
    cp ${ffpath}/${mol}/vacuum.mol2 ${mol}.mol2
    python ../scripts/applycoord_from_sdf.py ${mol}.mol2 ${mol}${pose}.sdf > ${mol}${pose}-p.mol2
    cp ${ffpath}/${mol}/vacuum.frcmod ${mol}${pose}-p.frcmod
    cp ${ffpath}/${mol}/leaprc_header ${mol}${pose}-p.leaprc
done
