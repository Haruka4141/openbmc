FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

AIC_KERNEL_DEVICETREE ?= "volans.dts"
SRC_URI += "file://${AIC_KERNEL_DEVICETREE}"
SRC_URI += "file://AIC_kernel.cfg"

KSRC = "git://github.com/AspeedTech-BMC/linux;protocol=https;branch=${KBRANCH}"
KBRANCH = "aspeed-master-v6.6"
LINUX_VERSION = "6.6.32"
SRCREV="24cbe56dfcf97618e7bee12218f4f33374b6bbf6"

do_patch:append() {
    for dts in "${AIC_KERNEL_DEVICETREE}"; do
        if [ -r "${WORKDIR}/${dts}" ]; then
            cp ${WORKDIR}/${dts} \
                ${STAGING_KERNEL_DIR}/arch/${ARCH}/boot/dts/aspeed/aspeed-ast2600-evb.dts
        fi
    done
}
