#!/bin/bash

WWW=/var/www/itv-vpn-hole.postland.org/html

./makeRoute.sh && (
  cp routes.txt ${WWW}/
  cp vpn-routes-full.rsc ${WWW}/
  echo -n > ${WWW}/routes-add.txt
  echo -n > ${WWW}/routes-del.txt
  echo -n > ${WWW}/vpn-routes-diff.rsc
)