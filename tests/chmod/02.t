#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8

desc="chmod returns ENAMETOOLONG if a component of a pathname exceeded {NAME_MAX} characters"

dir=`dirname $0`
. ${dir}/../misc.sh


nx=`namegen_max`
nxx="${nx}x"

expect 0 create ${nx} 0644
expect 0 chmod ${nx} 0620
expect 0620 stat ${nx} mode
expect 0 unlink ${nx}
expect ENAMETOOLONG chmod ${nxx} 0620

if supported lchmod; then
	expect 0 create ${nx} 0644
	expect 0 lchmod ${nx} 0620
	expect 0620 stat ${nx} mode
	expect 0 unlink ${nx}
	expect ENAMETOOLONG lchmod ${nxx} 0620
fi
