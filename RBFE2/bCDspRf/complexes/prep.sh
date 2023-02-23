for pair in PMZ1aspR-CPZ1aspR PMZ1aspR-PMT1aspR PMZ1aspR-TDZNR1aspR PMZ1aspR-TDZNS1aspR PMZ1aspR-TFP1aspR PMZ1aspR-TFP1bspR ; do
    jobname=bCDspR-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_mdlambda.py )  || exit 1
done 
