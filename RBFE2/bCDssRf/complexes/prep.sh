for pair in PMZ1assR-CPZ1assR PMZ1assR-PMT1assR PMZ1assR-TDZNR1assR PMZ1assR-TDZNS1assR PMZ1assR-TFP1assR PMZ1assR-TFP1bssR ; do
    jobname=bCDssR-$pair
    echo "Prepping $jobname"
    ( cd ${jobname} &&  ../../scripts/runopenmm ${jobname}_mintherm.py && ../../scripts/runopenmm ${jobname}_mdlambda.py )  || exit 1
done 
