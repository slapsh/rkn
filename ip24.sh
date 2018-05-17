#!/bin/bash

cut -f1,2,3 -d'.' ${1} | sort | uniq -c | grep -v '      1 ' | cut -c9- | awk '{ print $1 ".0/24" }'