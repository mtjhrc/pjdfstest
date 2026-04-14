#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8

desc="open returns ENAMETOOLONG if an entire path name exceeded ${PATH_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh


nx=`dirgen_max`
nxx="${nx}x"

mkdir -p "${nx%/*}"

expect 0 open ${nx} O_CREAT 0642
expect regular,0642 stat ${nx} type,mode
expect 0 unlink ${nx}
xfail Host:Darwin "virtiofs: macOS path_max is unreliable"
expect ENAMETOOLONG open ${nxx} O_CREAT 0642

rm -rf "${nx%%/*}"
