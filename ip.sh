#!/bin/bash

cut -f1 -d';' ${1} | tr -d ' ' | tr '|' '\n' | grep -v '/' | sort -u | grep -e '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*'