SUMMARY = "Enable USB ethernet"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

DEPENDS += "systemd"
RDEPENDS:${PN} += "libsystemd bash"

inherit allarch systemd

SRC_URI += "file://volans-usbnet.service \
            file://volans_usbnet.sh \
            file://00-bmc-usb0.network"

FILES:${PN}:append = " ${systemd_unitdir}/network/00-bmc-usb0.network"

do_install() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/volans-usbnet.service ${D}${systemd_unitdir}/system

    install -d ${D}/${sbindir}
    install -m 755 ${WORKDIR}/volans_usbnet.sh ${D}/${sbindir}

    install -d ${D}${sysconfdir_native}/systemd/network/
    install -m 0644 ${WORKDIR}/00-bmc-usb0.network ${D}${sysconfdir_native}/systemd/network
}

NATIVE_SYSTEMD_SUPPORT = "1"
SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "volans-usbnet.service"
