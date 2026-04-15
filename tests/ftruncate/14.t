#!/bin/sh
# vim: filetype=sh noexpandtab ts=8 sw=8

desc="truncate returns EFAULT if the path argument points outside the process's allocated address space"

dir=`dirname $0`
. ${dir}/../misc.sh


expect EFAULT truncate NULL 123
expect EFAULT truncate DEADCODE 123
