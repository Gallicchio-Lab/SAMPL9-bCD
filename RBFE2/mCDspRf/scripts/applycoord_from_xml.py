import os,sys,glob
import xml.etree.ElementTree as ET


# Usage:
# python applycoord_from_xml.py <mol2file> <xmlfile> <start> <displx> <disply> <displz>   > <newmol2file>
#

template = sys.argv[1]
xml_file = sys.argv[2]
start_idx = int(sys.argv[3])
dx = float(sys.argv[4])
dy = float(sys.argv[5])
dz = float(sys.argv[6])

ttype = 'unknown'
if template.find('.mol2') > 0:
    ttype = 'mol2' 
elif template.find('.sdf') > 0:
    ttype = 'sdf'

#get coordinates
tree = ET.parse(xml_file)
root = tree.getroot()
positions = root[2]

ncoord = 0
template_lines = []
with open(template) as infile:
    for line in infile:
        template_lines.append(line)
        if ttype == "mol2":
            if line.find(' LIG ') > 0 and line.find('RESIDUE') < 0:
                ncoord += 1
        elif ttype == "sdf":
            if len(line.strip().split()) == 10:
                ncoord += 1

coord = []
for i in range(start_idx,start_idx+ncoord):
    xyz = [0,0,0]
    xyz[0] = 10.*float(positions[i].attrib['x'])
    xyz[1] = 10.*float(positions[i].attrib['y'])
    xyz[2] = 10.*float(positions[i].attrib['z'])
    coord.append(xyz)


i = 0
outlines =""
for tline in template_lines:
    if ttype == "mol2":
        if tline.find(' LIG ') <= 0 or tline.find('RESIDUE') > 0:
            outlines += tline
            continue
        ttoks = tline.strip().split()
        outline="%7s %-8s%10.3f%10.3f%10.3f %-8s%8s %-8s%8s\n"%(
                ttoks[0], ttoks[1], coord[i][0]+dx, coord[i][1]+dy, coord[i][2]+dz, ttoks[5], ttoks[6], ttoks[7], ttoks[8])
        outlines += outline
    elif ttype == "sdf":
        if len(tline.strip().split()) < 10:
            outlines += tline
            continue
        ttoks = tline.strip().split()
        outline="%10.4f%10.4f%10.4f %2s  %3s%3s%3s%3s%3s%3s\n"%(
            coord[i][0]+dx, coord[i][1]+dy, coord[i][2]+dz, ttoks[3], ttoks[4], ttoks[5], ttoks[6], ttoks[7], ttoks[8], ttoks[9] )
        outlines += outline
    i += 1

print(outlines)
