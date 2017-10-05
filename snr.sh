#!/bin/bash
# Search `n Replace
# uses the_silver_searcher with xargs
# usage: snr.sh [search] [replace]
ag -0 -l $1 | xargs -0 sed -ri.bak -e "s/$1/$2/g"
