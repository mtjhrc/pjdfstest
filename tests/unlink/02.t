#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8

desc="unlink returns ENAMETOOLONG if a component of a pathname exceeded {NAME_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh


nx=`namegen_max`
nxx="${nx}x"

expect 0 create ${nx} 0644
expect 0 unlink ${nx}
expect ENOENT unlink ${nx}
expect ENAMETOOLONG unlink ${nxx}
