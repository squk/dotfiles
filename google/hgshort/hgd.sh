#!/bin/bash

HGSHORT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}}")" && pwd)"

source $HGSHORT_DIR/aliases.sh
cd $(hg hgd "$@")

CITC="${PWD#/google/src/cloud/$USER/}"
CITC="${CITC%/google3}"
echo "CitC $CITC"

hg l --color=always
