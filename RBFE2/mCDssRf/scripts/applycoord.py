import os,sys,glob

# Usage:
# cd bCDspS/ligands && python ../applycoord.py
#

ffpath = "../../ffmol2s"
sdfs = glob.glob('*.sdf')
for sdf in sdfs:
    lig = sdf.split('.')[0]
    template_mol2 = lig + ".mol2"
    print('Template ',template_mol2, os.path.isfile(template_mol2))
    template_lines = []
    ncoord = 0
    with open(template_mol2) as infile:
        for line in infile:
            template_lines.append(line)
            if line.find(' LIG ') > 0 and line.find('RESIDUE') < 0:
                ncoord += 1

    coord_lines = []
    with open(sdf) as infile:
        for line in infile:
            if len(line.strip().split()) == 10:
                coord_lines.append(line)
    print('Coord template SDF: ', ncoord, len(coord_lines))
    
    i = 0
    outlines =""
    for tline in template_lines:
        if tline.find(' LIG ') <= 0 or tline.find('RESIDUE') > 0:
            outlines += tline
            continue
        ttoks = tline.strip().split()
        toks = coord_lines[i].strip().split()
        outline="%7s %-8s%10s%10s%10s %-8s%8s %-8s%8s\n"%(
                ttoks[0], ttoks[1], toks[0], toks[1], toks[2], ttoks[5], toks[6], ttoks[7], ttoks[8])
        outlines += outline
        i += 1
    outname = sdf.replace('.sdf', '.mol2')
    with open(outname, 'w') as outfile:
        outfile.write(outlines)
