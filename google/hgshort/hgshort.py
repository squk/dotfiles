'''"shorthand" template filter to emit bash shorthand accessors.'''

import os
import sys

from mercurial import error
from mercurial import i18n
from mercurial import registrar
from mercurial import templateutil

# dict of template built-in functions
funcs = {}
templatefunc = registrar.templatefunc(funcs)
templatefilter = registrar.templatefilter()

evalboolean = templateutil.evalboolean
evalstring = templateutil.evalstring

bashvarsfile = None
if sys.stdout.isatty():
  if 'HGSHORT_BASH_VARS' in os.environ:
    bashvarsfile = os.environ['HGSHORT_BASH_VARS']

nextaliasidbytype = {
    b'a': ord(b'a'),
    b'A': ord(b'A')}


def writealias(name, value):
  if not bashvarsfile:
    return
  with open(bashvarsfile, 'a') as f:
    f.write("export %s='%s'\n" % (name.decode('utf-8'), value.decode('utf-8')))


def nextaliaschar(aliastype):
  if not bashvarsfile:
    return None
  aliasid = nextaliasidbytype[aliastype]
  if aliasid < ord(aliastype) + 26:
    nextaliasidbytype[aliastype] += 1
    return chr(aliasid).encode('utf-8')
  return None


def maybealias(value, aliastype):
  """Export as next bash alias and return id, or None."""
  aliaschar = nextaliaschar(aliastype)
  if not aliaschar: return None
  writealias(b'hgshort%s' % aliaschar, value)
  return aliaschar


@templatefilter(b'shorthand', intype=bytes)
def shorthand(text):
  """Export as next bash alias."""
  if not bashvarsfile:
    return b''
  aliaschar = maybealias(text, b'a')
  if not aliaschar:
    return b'  '
  return b'%s ' % aliaschar


@templatefunc(
    b'hgshort(text, aliastype)',
    argspec=b'text aliastype',
    requires={b'ui'})
def hgshort(context, mapping, args):
  """Export as next bash alias and return id, or None."""
  if not bashvarsfile:
    return b''
  if b'text' not in args or b'aliastype' not in args:
    raise error.ParseError(i18n._(b'hgshort() expects one to three arguments'))
  text = evalstring(context, mapping, args[b'text'])
  aliastype = evalstring(context, mapping, args[b'aliastype'])
  aliaschar = maybealias(text, aliastype)
  if not aliaschar:
    return b'  '
  aliastext = b'%s ' % aliaschar
  ui = context.resource(mapping, b'ui')
  return ui.label(aliastext, b'hgshort.alias')
