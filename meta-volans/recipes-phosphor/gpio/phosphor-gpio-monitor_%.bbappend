FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit systemd
inherit obmc-phosphor-systemd

RDEPENDS:${PN}-monitor += "bash"
RDEPENDS:${PN} += "bash"

SRC_URI += "file://phosphor-multi-gpio-monitor.json \
            file://toggle_identify_led.sh"

SYSTEMD_SERVICE:${PN}-monitor += "id-button-pressed.service"

FILES:${PN}-monitor += "${datadir}/${PN}/phosphor-multi-gpio-monitor.json \
                        /usr/sbin/toggle_identify_led.sh"

SYSTEMD_LINK:${PN}-monitor:append = " ../phosphor-multi-gpio-monitor.service:multi-user.target.requires/phosphor-multi-gpio-monitor.service"

do_install:append() {
    install -d ${D}${sbindir}
    install -m 0644 ${WORKDIR}/phosphor-multi-gpio-monitor.json ${D}${datadir}/${PN}/
    install -m 0755 ${WORKDIR}/toggle_identify_led.sh ${D}${sbindir}/
}
