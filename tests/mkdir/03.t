#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8

desc="mkdir returns ENAMETOOLONG if an entire path name exceeded {PATH_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh


nx=`dirgen_max`
nxx="${nx}x"

mkdir -p "${nx%/*}"

expect 0 mkdir ${nx} 0755
expect 0 rmdir ${nx}
xfail Host:Darwin "virtiofs: macOS path_max is unreliable"
expect ENAMETOOLONG mkdir ${nxx} 0755

rm -rf "${nx%%/*}"
