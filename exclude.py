#!/usr/bin/env python

import sys
import ipaddress

exNetworks = []

with open('net-except.txt') as f:
    for line in f:
        line = line.strip().encode().decode()  # Python 2/3 dual support.
        if line == u'':
            continue
        try:
            network = ipaddress.ip_network(line, strict=False)
            if network not in exNetworks:
		exNetworks.append(network)
        except ValueError:
	    pass
f.close

#print('\n'.join(map(str, exNetworks)))

for line in sys.stdin:
    line = line.strip().encode().decode()  # Python 2/3 dual support.
    if line == u'':
        continue
    try:
        network = ipaddress.ip_network(line, strict=False)
	overlapped = False
	for exNet in exNetworks:
            if network.overlaps(exNet):
		print('\n'.join(map(str, list(network.address_exclude(exNet)))))
		overlapped = True
	if not overlapped:
	    print(line)
    except ValueError:
	pass
