#!/bin/bash

WWW=/var/www/itv-vpn-hole.postland.org/html

./makeRoute.sh diff && (
  cp routes-add.txt ${WWW}/
  cp routes-del.txt ${WWW}/
  cp vpn-routes-diff.rsc ${WWW}/
)