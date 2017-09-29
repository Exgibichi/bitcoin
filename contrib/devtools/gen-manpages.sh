#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

STATUSQUOD=${STATUSQUOD:-$SRCDIR/statusquod}
STATUSQUOCLI=${STATUSQUOCLI:-$SRCDIR/statusquo-cli}
STATUSQUOTX=${STATUSQUOTX:-$SRCDIR/statusquo-tx}
STATUSQUOQT=${STATUSQUOQT:-$SRCDIR/qt/statusquo-qt}

[ ! -x $STATUSQUOD ] && echo "$STATUSQUOD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
SQVER=($($STATUSQUOCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for statusquod if --version-string is not set,
# but has different outcomes for statusquo-qt and statusquo-cli.
echo "[COPYRIGHT]" > footer.h2m
$STATUSQUOD --version | sed -n '1!p' >> footer.h2m

for cmd in $STATUSQUOD $STATUSQUOCLI $STATUSQUOTX $STATUSQUOQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${SQVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${SQVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
