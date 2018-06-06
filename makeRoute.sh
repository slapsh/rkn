#!/bin/bash

#URL='https://sourceforge.net/p/z-i/code-0/HEAD/tree/dump.csv?format=raw'
URL='https://github.com/zapret-info/z-i/raw/master/dump.csv'
RKN='dump.csv'

curl --connect-timeout 10 -L -o ${RKN} ${URL} || exit 1
./net.sh ${RKN} > net.txt
./ip.sh ${RKN} > ip.txt
./ip24.sh ip.txt > ip24.txt
grep -v '^#' net-manual.txt | grep -v '^$' >> net.txt
if [ "${1}" == "diff" ]
then
  cat net.txt ip.txt ip24.txt | ./supernets.py > routes-new.txt
  diff -U 0 routes.txt routes-new.txt | sed '1,2d' | grep '^-' | cut -c2- > routes-del.txt
  diff -U 0 routes.txt routes-new.txt | sed '1,2d' | grep '^+' | cut -c2- > routes-add.txt
  mv routes-new.txt routes.txt
  cat routes-del.txt | awk '{ print "/ip route remove [ find distance=1 dst-address=" $1 " gateway=ovpn-rkn ]" }' > vpn-routes-diff.rsc
  cat routes-add.txt | awk '{ print "/ip route add distance=1 dst-address=" $1 " gateway=ovpn-rkn" }' >> vpn-routes-diff.rsc
  echo -n '+'
  cat routes-add.txt | wc -l
  echo -n '-'
  cat routes-del.txt | wc -l
else
  cat net.txt ip.txt ip24.txt | ./supernets.py > routes.txt
  echo "/ip route remove [ find gateway=ovpn-rkn static=yes ]" > vpn-routes-full.rsc
  cat routes.txt | awk '{ print "/ip route add distance=1 dst-address=" $1 " gateway=ovpn-rkn" }' >> vpn-routes-full.rsc
fi
