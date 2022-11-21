#!/bin/sh

set -e

# Create the revert script for manually switching back to the previously
# active firmware.
mkdir -p $TARGET_DIR/usr/share/fwup
$HOST_DIR/usr/bin/fwup -c -f $NERVES_DEFCONFIG_DIR/fwup-revert.conf -o $TARGET_DIR/usr/share/fwup/revert.fw

# Copy the fwup includes to the images dir
cp -rf $NERVES_DEFCONFIG_DIR/fwup_include $BINARIES_DIR

# Copy over AX210 Firmware
rm -rf $TARGET_DIR/lib/firmware/iwlwifi*
cp -f $BUILD_DIR/linux-firmware-*/iwlwifi-ty-a0-gf-a0-66.ucode $TARGET_DIR/lib/firmware
cp -f $BUILD_DIR/linux-firmware-*/iwlwifi-ty-a0-gf-a0.pnvm $TARGET_DIR/lib/firmware
mkdir -p $TARGET_DIR/lib/firmware/intel >/dev/null 2>&1
cp -f $BUILD_DIR/linux-firmware-*/intel/ibt-0041-0041.sfi $TARGET_DIR/lib/firmware/intel
cp -f $BUILD_DIR/linux-firmware-*/intel/ibt-0041-0041.ddc $TARGET_DIR/lib/firmware/intel
