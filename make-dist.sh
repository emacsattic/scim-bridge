#!/bin/bash
# Copyright (c) 2010 and onwards, S. Irie
# This program is distributed under the MIT Licence.

EL_DEV="scim-bridge-dev.el"
EL_MAIN="scim-bridge.el"
DBGREGEXP="^;*\t* *(if scim-debug ("

FILES=("README" "COPYING" "ChangeLog" "l10n" "l10n-dev")

VERSION=$(sed -n 's/^(defconst scim-mode-version "\(.*\)")$/\1/p' scim-bridge-dev.el)
ARCHDIR="scim-bridge-el-${VERSION}"
ARCHFILE="${ARCHDIR}.tar.gz"

rm -rfv $ARCHDIR
mkdir -v $ARCHDIR

echo "comment out debug codes in $EL_DEV -> ${ARCHDIR}/${EL_MAIN}"
sed "s/\(${DBGREGEXP}\)/;#\1/" $EL_DEV > ${ARCHDIR}/${EL_MAIN}

for i in ${FILES[@]}; do
    cp -rpv $i $ARCHDIR
done

echo "create archve $ARCHFILE"
tar cvzf $ARCHFILE $ARCHDIR
