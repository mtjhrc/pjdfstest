#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8

desc="rename returns ENAMETOOLONG if an entire length of either path name exceeded {PATH_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh

echo "1..6"

n0=`namegen`
nx=`dirgen_max`
nxx="${nx}x"

mkdir -p "${nx%/*}"

expect 0 create ${n0} 0644
expect 0 rename ${n0} ${nx}
expect 0 rename ${nx} ${n0}
todo Linux "libkrun/virtiofs macOS deals poorly with path_max"
expect ENAMETOOLONG rename ${n0} ${nxx}
todo Linux "libkrun/virtiofs macOS deals poorly with path_max"
expect 0 unlink ${n0}
todo Linux "libkrun/virtiofs macOS deals poorly with path_max"
expect ENAMETOOLONG rename ${nxx} ${n0}

rm -rf "${nx%%/*}"
