#!/usr/bin/env python
import argparse

import parmed

MASS_DICT = {
      1008: 1,
     12010: 6,
     14010: 7,
     16000: 8,
     19000: 9,
     24305: 12,
     30970: 15,
     32060: 16,
     35450: 17,
     40080: 20,
     55000: 26,
     63550: 29,
     65400: 30,
     79900: 35,
    126900: 53,
}


def _correct_parm_elem(parm_file):
    """
    This function corrects the element and atomic number values that are
    incorrectly assigned to certain atoms when ffgen parameters are used.
    """
    scale = 1000.0
    tmp_mol = parmed.load_file(parm_file)
    for a in tmp_mol.atoms:
        massid = round(scale*a.mass)
        if massid in MASS_DICT.keys():
            ref_elem = MASS_DICT[massid]
            if a.element != ref_elem:
                a.element = ref_elem
                a.atomic_number = ref_elem
            else:
                continue
        else:
            continue
    tmp_mol.save(parm_file, overwrite=True)


parser = argparse.ArgumentParser()
parser.add_argument("parm_file", help="name of the parm file", type=str)
args = parser.parse_args()
parm_file = args.parm_file
_correct_parm_elem(parm_file)
