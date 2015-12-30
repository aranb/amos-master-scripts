#!/bin/bash

export TABLE="usertable"
export CF="fam"
export VERSIONS="1000000"

hbase shell << EOF
   list
   disable 'OMID_COMMIT_TABLE'
   drop 'OMID_COMMIT_TABLE'
   disable 'OMID_TIMESTAMP'
   drop 'OMID_TIMESTAMP'
EOF

