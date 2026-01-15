#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8

desc="link returns ENAMETOOLONG if an entire length of either path name exceeded {PATH_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh

require link

echo "1..13"

n0=`namegen`
nx=`dirgen_max`
nxx="${nx}x"

mkdir -p "${nx%/*}"

expect 0 create ${nx} 0644
expect 0 link ${nx} ${n0}
expect 2 stat ${n0} nlink
expect 2 stat ${nx} nlink
expect 0 unlink ${nx}
expect 0 link ${n0} ${nx}
expect 2 stat ${n0} nlink
expect 2 stat ${nx} nlink
expect 0 unlink ${nx}
todo Linux "libkrun/virtiofs macOS deals poorly with path_max"
expect ENAMETOOLONG link ${n0} ${nxx}
todo Linux "libkrun/virtiofs can't honor number of links"
expect 1 stat ${n0} nlink
expect 0 unlink ${n0}
todo Linux "libkrun/virtiofs macOS deals poorly with path_max"
expect ENAMETOOLONG link ${nxx} ${n0}

rm -rf "${nx%%/*}"
