FILESEXTRAPATHS:prepend:volans := "${THISDIR}/${PN}:"

SRC_URI:append:volans = "file://volans-resolv.conf"
SRC_URI:append:volans = "${@bb.utils.contains('MACHINE_FEATURES', 'bonding', ' file://10-bmc-bond0.netdev', '', d)}"
SRC_URI:append:volans = "${@bb.utils.contains('MACHINE_FEATURES', 'bonding', ' file://bond-eth0.conf', '', d)}"
SRC_URI:append:volans = "${@bb.utils.contains('MACHINE_FEATURES', 'bonding', ' file://bond-eth1.conf', '', d)}"

FILES:${PN}:append:volans = "${sysconfdir_native}/systemd/resolved.conf.d/volans-resolv.conf"
FILES:${PN}:append:volans = "${@bb.utils.contains("MACHINE_FEATURES", "bonding", " ${sysconfdir_native}/systemd/network/10-bmc-bond0.netdev", "", d)}"
FILES:${PN}:append:volans = "${@bb.utils.contains("MACHINE_FEATURES", "bonding", " ${sysconfdir_native}/systemd/network/00-bmc-eth0.network.d/bond-eth0.conf", "", d)}"
FILES:${PN}:append:volans = "${@bb.utils.contains("MACHINE_FEATURES", "bonding", " ${sysconfdir_native}/systemd/network/00-bmc-eth1.network.d/bond-eth1.conf", "", d)}"

do_install:append:volans() {
    install -d ${D}${sysconfdir_native}/systemd/resolved.conf.d/
    install -m 0644 ${WORKDIR}/volans-resolv.conf ${D}${sysconfdir_native}/systemd/resolved.conf.d/
    if ${@bb.utils.contains('MACHINE_FEATURES', 'bonding', 'true', 'false', d)}; then
        install -d ${D}${sysconfdir_native}/systemd/network/
        install -d ${D}${sysconfdir_native}/systemd/network/00-bmc-eth0.network.d/
        install -d ${D}${sysconfdir_native}/systemd/network/00-bmc-eth1.network.d/
        install -m 0644 ${WORKDIR}/bond-eth0.conf ${D}${sysconfdir_native}/systemd/network/00-bmc-eth0.network.d/
        install -m 0644 ${WORKDIR}/bond-eth1.conf ${D}${sysconfdir_native}/systemd/network/00-bmc-eth1.network.d/
        install -m 0644 ${WORKDIR}/10-bmc-bond0.netdev ${D}${sysconfdir_native}/systemd/network
    fi
}