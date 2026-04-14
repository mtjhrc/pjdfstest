#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8

desc="chown returns ENAMETOOLONG if an entire path name exceeded {PATH_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh


nx=`dirgen_max`
nxx="${nx}x"

mkdir -p "${nx%/*}"

expect 0 create ${nx} 0644
expect 0 chown ${nx} 65534 65534
expect 65534,65534 stat ${nx} uid,gid
expect 0 unlink ${nx}
xfail Host:Darwin "virtiofs: macOS path_max is unreliable"
expect ENAMETOOLONG chown ${nxx} 65534 65534

expect 0 create ${nx} 0644
expect 0 lchown ${nx} 65534 65534
expect 65534,65534 stat ${nx} uid,gid
expect 0 unlink ${nx}
xfail Host:Darwin "virtiofs: macOS path_max is unreliable"
expect ENAMETOOLONG lchown ${nxx} 65534 65534

rm -rf "${nx%%/*}"
