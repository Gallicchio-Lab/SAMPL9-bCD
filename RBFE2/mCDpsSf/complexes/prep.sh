for pair in PMZ1apsS-CPZ1apsS PMZ1apsS-PMT1apsS PMZ1apsS-TDZNR1apsS PMZ1apsS-TDZNS1apsS PMZ1apsS-TFP1apsS PMZ1apsS-TFP1bpsS ; do
    jobname=mCDpsS-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_mdlambda.py )  || exit 1
done 
