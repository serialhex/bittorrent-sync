#!/bin/bash

if [[ $0 == '/bin/bash' ]]; then
	echo "It looks like you're sourcing this script."
	echo "Please execute it directly instead, lest it clutter your shell with variables."
	return 1
fi

grep -vE "^[[:space:]]*(if|elif|else|fi)" PKGBUILD > PKGBUILD.geninteg

newsums=( )
for l in $(makepkg -g -p PKGBUILD.geninteg | grep -oE "[0-9a-f]{64}"); do
	newsums+=("$l")
done

rm PKGBUILD.geninteg

oldsums=( )
for l in $(grep -oE "[0-9a-f]{64}|SKIP" PKGBUILD); do
	oldsums+=("$l")
done

SCRIPT_NAME=$0.sed
for i in ${!oldsums[@]}; do
	if [ "${oldsums[i]}" == 'SKIP' ]; then
		echo 'SKIP > SKIP'
	else
		echo "${oldsums[i]} > ${newsums[i]}"
		echo "s/${oldsums[i]}/${newsums[i]}/" >> $SCRIPT_NAME
	fi
done

sed -i.bak -f $SCRIPT_NAME PKGBUILD && rm $SCRIPT_NAME
