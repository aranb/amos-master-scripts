#!/bin/bash
source $HOME/.bashrc

export sdir="$HOME/git/amos-master-scripts"
${sdir}/setup-dirs.sh

ssh slave1 ${sdir}/setup-dirs.sh
ssh slave2 ${sdir}/setup-dirs.sh

/proj/End2end/loctx/inst/hadoop/bin/hdfs namenode -format
