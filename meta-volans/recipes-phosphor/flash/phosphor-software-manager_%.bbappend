FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://bios-update.sh"
PACKAGECONFIG:append = " flash_bios"
RDEPENDS:${PN} += "bash"

FILES:${PN}-updater += " /usr/sbin/bios-update.sh "

do_install:append() {
    install -d ${D}/${sbindir}
    install -m 0755 ${WORKDIR}/bios-update.sh ${D}/${sbindir}/
}