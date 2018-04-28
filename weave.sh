#!/bin/bash

IFS='~'
FORMAT_CMD="sed -E -e 's/^/    /g' -e 's/^    %%% ?//g' -i {}"
APPLY_CMD="find ./doc -name '*' -type f -exec $FORMAT_CMD \;"

rm -r doc/*
cp --parents -r src/* doc
echo $APPLY_CMD
eval $APPLY_CMD

