#!/bin/bash

# Back up PKGBUILD
if cp PKGBUILD PKGBUILD.bak; then
	echo "PKGBUILD copied to PKGBUILD.bak"
else
	echo "Failed to backup PKGBUILD, exiting"
	exit 1
fi

grep -vE "^[[:space:]]*(if|elif|else|fi)" PKGBUILD > PKGBUILD.geninteg

newsums=( )
for l in $(makepkg -g -p PKGBUILD.geninteg | grep -oE "[0-9a-f]{64}"); do
	newsums+=("$l")
done

oldsums=( )
for l in $(grep -oE "[0-9a-f]{64}|SKIP" PKGBUILD); do
	oldsums+=("$l")
done

for i in ${!oldsums[@]}; do
	if [ "${oldsums[i]}" == 'SKIP' ]; then
		echo 'SKIP > SKIP'
	else
		echo "${oldsums[i]} > ${newsums[i]}"
		sed "s/${oldsums[i]}/${newsums[i]}/" PKGBUILD > NEW_PKGBUILD && mv NEW_PKGBUILD PKGBUILD
	fi
done
