FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

AIC_KERNEL_DEVICETREE ?= "volans.dts"
SRC_URI += "file://${AIC_KERNEL_DEVICETREE}"
SRC_URI += "file://aspeed-g6.dtsi"
SRC_URI += "file://AIC_kernel.cfg"
SRC_URI += "file://037-linux_drivers_soc_aspeed_espi.patch"
SRC_URI += "file://238-aspeed_espi_oob_flash.patch"
SRC_URI += "file://003-BeechnutCity_espi_setting.patch"
SRC_URI += "file://018-linux_drivers_soc_aspeed.patch"

do_patch:append() {
    for dts in "${AIC_KERNEL_DEVICETREE}"; do
        if [ -r "${WORKDIR}/${dts}" ]; then
            cp ${WORKDIR}/${dts} \
                ${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts/aspeed/aspeed-ast2600-evb.dts
        fi
    done
    cp ${WORKDIR}/aspeed-g6.dtsi ${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts/aspeed/aspeed-g6.dtsi
}
