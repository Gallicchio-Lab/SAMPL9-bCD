for pair in PMZ1appR-CPZ1appR PMZ1appR-PMT1appR PMZ1appR-TDZNR1appR PMZ1appR-TDZNS1appR PMZ1appR-TFP1appR PMZ1appR-TFP1bppR ; do
    jobname=bCDppR-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_mdlambda.py )  || exit 1
done 
