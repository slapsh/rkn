#!/bin/bash

cut -f1 -d';' ${1} | tr -d ' ' | tr '|' '\n' | grep '/' | sort -nu