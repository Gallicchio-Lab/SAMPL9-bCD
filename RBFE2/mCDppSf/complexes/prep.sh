for pair in PMZ1appS-CPZ1appS PMZ1appS-PMT1appS PMZ1appS-TDZNR1appS PMZ1appS-TDZNS1appS PMZ1appS-TFP1appS PMZ1appS-TFP1bppS ; do
    jobname=mCDppS-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_mdlambda.py )  || exit 1
done 
