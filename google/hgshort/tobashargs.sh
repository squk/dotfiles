#!/bin/bash

HGSHORT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}}")" && pwd)"

export HGSHORT_BASH_CMD="$1"
export HGSHORT_BASH_ARGS="/tmp/HGSHORT-bash-args-$$.sh"

shift
$HGSHORT_DIR/tobashargs.py "$@" > $HGSHORT_BASH_ARGS
xargs --null --arg-file=$HGSHORT_BASH_ARGS $HGSHORT_BASH_CMD
\rm $HGSHORT_BASH_ARGS  # don't call rm to avoid alias loop
