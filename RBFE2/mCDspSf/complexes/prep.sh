for pair in PMZ1aspS-CPZ1aspS PMZ1aspS-PMT1aspS PMZ1aspS-TDZNR1aspS PMZ1aspS-TDZNS1aspS PMZ1aspS-TFP1aspS PMZ1aspS-TFP1bspS ; do
    jobname=mCDspS-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_mdlambda.py )  || exit 1
done 
