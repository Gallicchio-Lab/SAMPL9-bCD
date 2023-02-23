import sys
inpath = sys.argv[1]
outpath = inpath.split('.')
if len(outpath) > 1:
    outpath = '.'.join(outpath[:-1]) + '_ucase.' + outpath[-1]
else:
    outpath = outpath[0] + '_ucase'

open(outpath,'w').write(open(inpath,'r').read().upper().replace('SP','sp'))
