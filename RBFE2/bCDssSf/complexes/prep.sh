for pair in PMZ1assS-CPZ1assS PMZ1assS-PMT1assS PMZ1assS-TDZNR1assS PMZ1assS-TDZNS1assS PMZ1assS-TFP1assS PMZ1assS-TFP1bssS ; do
    jobname=bCDssS-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_mdlambda.py )  || exit 1
done 
