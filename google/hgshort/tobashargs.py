#! /usr/bin/python3
"""Converts single letters like X to bash variable references like $hgshortX."""

import os
import re
import sys

# Shortands can be prefixed with an 'r', in which case several can be used in
# one argument. This is useful for revsets, for example: 'rA::rD'.
ALIAS_RE = re.compile(r'^([a-zA-Z])$|\br([A-Z])\b')


def subst(match):
  char = match.group(1) or match.group(2)

  var = 'hgshort%s' % char
  if var in os.environ:
    return os.getenv(var, '')

  return match.group(0)


def substall(s):
  return ALIAS_RE.sub(subst, s)


# Don't process first argument for `hg`, since it's often a command abbreviated
# to a single letter.
if 'HGSHORT_IS_HG' in os.environ:
  args = sys.argv[1:2] + list(substall(a) for a in sys.argv[2:])
else:
  args = list(substall(a) for a in sys.argv[1:])

# sys.stderr.write('%s\n' % repr(args))  # debug only
sys.stdout.write(chr(0).join(args))
