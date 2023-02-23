for pair in PMZ1apsR-CPZ1apsR PMZ1apsR-PMT1apsR PMZ1apsR-TDZNR1apsR PMZ1apsR-TDZNS1apsR PMZ1apsR-TFP1apsR PMZ1apsR-TFP1bpsR ; do
    jobname=bCDpsR-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_mdlambda.py )  || exit 1
done 
