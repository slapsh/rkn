#!/bin/sh

nslookup -q=TXT _cloud-netblocks.googleusercontent.com  8.8.8.8 | grep text | tr ' ' '\n' | grep include | cut -f2 -d':' | xargs -n 1 -I % nslookup -q=TXT % 8.8.8.8 | grep text | tr ' ' '\n' | grep ip4 | cut -f2 -d':'