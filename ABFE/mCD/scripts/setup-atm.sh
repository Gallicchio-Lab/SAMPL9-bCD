 #!/bin/bash

#load settings
work_dir=$(pwd)
scripts_dir=${work_dir}/scripts
source ${scripts_dir}/setup-settings.sh

cd ${work_dir} || exit 1

#these atoms are restrained.
#Indexes are shifted by 1 as they are expected to start from 0 in the OpenMM scripts
cup_atoms="45 52 59 66 73 80 87"
for i in $cup_atoms; do
    if [ -z "$restr_atoms" ] ; then
	restr_atoms=$i
    else
	restr_atoms="${restr_atoms}, $i"
    fi
done
echo "Indexes of the restrained atoms:"
echo "$restr_atoms"

#get the list of receptor atoms that define the centroid of the binding site
rcpt_cm_atoms="45 52 59 66 73 80 87"
for i in $rcpt_cm_atoms; do
    if [ -z "$vsite_rcpt_atoms" ] ; then
	vsite_rcpt_atoms=$i
    else
	vsite_rcpt_atoms="${vsite_rcpt_atoms}, $i"
    fi
done
echo "Vsite receptor atoms:"
echo "$vsite_rcpt_atoms"

#process each ligand
nligands=${#ligands[@]}
nlig_m1=$(expr ${#ligands[@]} - 1)

cd ${work_dir} || exit 1
for l in `seq 0 ${nlig_m1}` ; do
    
    lig=${ligands[$l]}
    
    echo "Processing ligand  $lig..."
    
    #retrieve number of atoms of the receptor and
    #and those of the ligands from their mol2 files
    num_atoms_rcpt=189
    num_atoms_lig=$(  awk 'NR==3{print $1}' ${work_dir}/ligands/${lig}.mol2 ) || exit 1

    #list of ligand atoms (starting from zero) assuming they are listed soon after the receptor
    n1=$( expr $num_atoms_rcpt + $num_atoms_lig - 1 )
    lig_atoms=""
    for i in $( seq $num_atoms_rcpt $n1 ); do
	if [ -z "$lig_atoms" ] ; then
	    lig_atoms=$i
	else
	    lig_atoms="${lig_atoms}, $i"
	fi
    done
    
    echo "atoms of $lig are $lig_atoms"
    
    #creates system in complexes folder
    jobname=${receptor}-${lig}
    mkdir -p ${work_dir}/complexes/${jobname} || exit 1
    
    cd ${work_dir}/complexes/${jobname}    || exit 1
    
    cat >tleap.cmd <<EOF
source leaprc.water.tip3p
source "${work_dir}/receptor/${receptor}-p.leaprc"
RCPT = loadmol2 "${work_dir}/receptor/${receptor}-p.mol2"
loadamberparams "${work_dir}/receptor/${receptor}-p.frcmod"
source "${work_dir}/ligands/${lig}-p.leaprc"
LIG = loadmol2 "${work_dir}/ligands/${lig}-p.mol2"
loadamberparams "${work_dir}/ligands/${lig}-p.frcmod"
MOL = combine {RCPT LIG}
addions2 MOL Na+ 0
addions2 MOL Cl- 0
solvateBox MOL TIP3PBOX 10.0
saveamberparm MOL ${jobname}.prmtop ${jobname}.inpcrd
savepdb MOL ${jobname}.pdb
quit
EOF
    echo "tleap -f tleap.cmd"
    tleap -f tleap.cmd || exit 1
    
    displs=""
    count=0
    for d in ${displacement[@]}; do
	displs="$displs $d"
	count=$(expr $count + 1 )
    done
    echo "Displacement vector: $displs"

    #builds mintherm, npt, and equilibration scripts
    replstring="s#<JOBNAME>#${jobname}# ; s#<DISPLX>#${displacement[0]}# ; s#<DISPLY>#${displacement[1]}# ; s#<DISPLZ>#${displacement[2]}# ; s#<VSITERECEPTORATOMS>#${vsite_rcpt_atoms}# ; s#<RESTRAINEDATOMS>#${restr_atoms}# ; s#<LIGATOMS>#${lig_atoms}#" 
    sed "${replstring}" < ${work_dir}/scripts/mintherm_template.py > ${jobname}_mintherm.py || exit 1
    sed "${replstring}" < ${work_dir}/scripts/equil_template.py > ${jobname}_equil.py || exit 1
    sed "${replstring}" < ${work_dir}/scripts/mdlambda_template.py > ${jobname}_mdlambda.py || exit 1
    sed "${replstring}" < ${work_dir}/scripts/asyncre_template.cntl > ${jobname}_asyncre.cntl || exit 1

    #copy runopenmm, nodefile, slurm files, etc
    cp ${work_dir}/scripts/runopenmm ${work_dir}/scripts/nodefile ${work_dir}/complexes/${jobname}/
    
    sed "s#<JOBNAME>#${jobname}#;s#<ASYNCRE_DIR>#${asyncre_dir}#" < ${work_dir}/scripts/run_template.sh > ${work_dir}/complexes/${jobname}/run.sh
    cp ${work_dir}/scripts/analyze.sh ${work_dir}/scripts/uwham_analysis.R ${work_dir}/complexes/${jobname}/
    
done

#prepare prep script
ligs=${ligands[@]}
sed "s#<RECEPTOR>#${receptor}#;s#<LIGS>#${ligs}# " < ${work_dir}/scripts/prep_template.sh > ${work_dir}/complexes/prep.sh

#prepare free energy calculation script
sed "s#<RECEPTOR>#${receptor}#;s#<LIGS>#${ligs}# " < ${work_dir}/scripts/free_energies_template.sh > ${work_dir}/complexes/free_energies.sh
