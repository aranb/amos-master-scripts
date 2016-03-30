#!/bin/bash

export TABLE="usertable"
export CF="fam"
export VERSIONS="1000000"
export bdir=${pdir}
export splits=$1

hbase shell << EOF
   list
   disable '${TABLE}'
   drop '${TABLE}'
   n_splits = ${splits}
   create '${TABLE}', '${CF}'#, {SPLITS => (1..n_splits).map {|i| "user#{i*(10000/(n_splits+1))}"}}
   alter '${TABLE}', {NAME=>'${CF}', VERSIONS=>${VERSIONS}}
   describe '${TABLE}'
EOF

ssh -T tso << EOF
   ${bdir}/inst/tso-server/bin/omid.sh create-hbase-commit-table -numSplits 3
   ${bdir}/inst/tso-server/bin/omid.sh create-hbase-timestamp-table
EOF

hbase shell << EOF
   list
EOF
