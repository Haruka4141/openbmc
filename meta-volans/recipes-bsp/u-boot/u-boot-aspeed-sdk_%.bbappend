FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

AIC_UBOOT_DEVICETREE ?= "volans.dts"
SRC_URI:append = " file://${AIC_UBOOT_DEVICETREE}"
SRC_URI:append = " file://001-arch_arm_mach-aspeed_ast2600_board_common.patch"
SRC_URI:append = " file://AIC_uboot.cfg"

AIC_post_do_patch() {
    for DTS in "${AIC_UBOOT_DEVICETREE}"; do
        if [ -r "${WORKDIR}/${DTS}" ]; then
            cp ${WORKDIR}/${DTS} \
                ${WORKDIR}/git/arch/${ARCH}/dts/ast2600-evb.dts
        fi
    done
}
do_patch[postfuncs] += "AIC_post_do_patch"