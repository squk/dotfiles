#!/bin/bash

HGSHORT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}}")" && pwd)"

export HGSHORT_BASH_VARS="/tmp/hgshort-bash-vars-$$.sh"
export HGSHORT_BASH_ARGS="/tmp/hgshort-bash-args-$$.sh"

if [[ -f $HGSHORT_BASH_VARS ]]; then
  \rm $HGSHORT_BASH_VARS  # don't call rm to avoid alias loop
fi

HGSHORT_IS_HG=1 $HGSHORT_DIR/tobashargs.py "$@" > $HGSHORT_BASH_ARGS
xargs --null --arg-file=$HGSHORT_BASH_ARGS \
  hg --config extensions.hgshort=$HGSHORT_DIR/hgshort.py
\rm $HGSHORT_BASH_ARGS  # don't call rm to avoid alias loop

if [[ -f $HGSHORT_BASH_VARS ]]; then
  source $HGSHORT_BASH_VARS
  \rm $HGSHORT_BASH_VARS  # don't call rm to avoid alias loop
fi
