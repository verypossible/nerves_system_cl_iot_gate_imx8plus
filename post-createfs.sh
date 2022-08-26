#!/bin/sh

set -e

FWUP_CONFIG=$NERVES_DEFCONFIG_DIR/fwup.conf

# Run the common post-image processing for nerves
$BR2_EXTERNAL_NERVES_PATH/board/nerves-common/post-createfs.sh $TARGET_DIR $FWUP_CONFIG

UBOOT_DTB=${BINARIES_DIR}/iot-gate-imx8plus.dtb

cp ${BINARIES_DIR}/u-boot-spl.bin ${BINARIES_DIR}/u-boot-spl-no-pad.bin
cp ${BINARIES_DIR}/tee-pager_v2.bin ${BINARIES_DIR}/tee.bin
dd if=${BINARIES_DIR}/u-boot-spl-no-pad.bin of=${BINARIES_DIR}/u-boot-spl.bin bs=4 conv=sync
