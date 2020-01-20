#!/bin/sh

VARKRNL="wmtd"		# std + ext2-4 + gk_flash
#VARKRNL="nofl"		# std + ext2-4 - gk_flash
#VARKRNL="netf_nofl"	# std + ext2-4 + netfilter - gk_flash

BASEDIR="$( cd "$(dirname "$0")" ; pwd -P )"
CKERNEL="$BASEDIR/zImage_$VARKRNL"
CMDFILE="$BASEDIR/cmdline_$VARKRNL"
[ -f "$CKERNEL" ] || exit 1
# we need ./cmdline_<variant> too
[ -f "$CMDFILE" ] && CMDLINE="`cat $CMDFILE`"
[ -n "$CMDLINE" ] || exit 1

# you might need to fix PATH to include kexec
kexec -l --atag --command-line=\"$CMDLINE\" -c $CKERNEL && kexec -e
