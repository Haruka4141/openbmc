FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

AIC_KERNEL_DEVICETREE ?= "volans.dts"
SRC_URI += "file://${AIC_KERNEL_DEVICETREE}"

do_patch:append() {
    for dts in "${AIC_KERNEL_DEVICETREE}"; do
        if [ -r "${WORKDIR}/${dts}" ]; then
            cp ${WORKDIR}/${dts} \
                ${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts/aspeed-ast2600-evb.dts
        fi
    done
}
