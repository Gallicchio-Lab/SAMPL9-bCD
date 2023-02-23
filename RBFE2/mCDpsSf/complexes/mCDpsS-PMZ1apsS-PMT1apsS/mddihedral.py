import os
import mdtraj as md
import numpy as np


jobname = os.path.basename(os.getcwd())

pmz1_phi1 = [197, 206, 204, 203]
pmt1_phi1 = [238, 247, 245, 246]
indices = np.array( [pmz1_phi1, pmt1_phi1] )
to_deg = 180.0/np.pi

for r in range(0,22):
    traj = md.load("r%d/%s.dcd" % (r, jobname)   ,top="%s_0.pdb" % jobname )
    p = to_deg*md.compute_dihedrals(traj, indices)
    ntraj = p.shape[0]
    nout = 0
    with open("r%d/%s.out" % (r, jobname)) as f:
        for line in f:
            print(nout, line.rstrip(), " ", p[nout,0], p[nout,1])
            nout += 1
    assert nout == ntraj, "Inconsistent no. samples %d and traj length %d" % (nout, ntraj)

# in R:
#   data <- read.table('data')
#   hist(data$V12[ data$V1 > 300 & data$V2 == 0], breaks=seq(from = -180, to = 180, by = 20), xlim=c(-180,180))
    
