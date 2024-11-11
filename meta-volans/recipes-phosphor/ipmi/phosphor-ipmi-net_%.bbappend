DEFAULT_RMCPP_IFACE = "eth0"

ALT_RMCPP_IFACE = "eth1"
SYSTEMD_SERVICE:${PN} += " \
        ${PN}@${ALT_RMCPP_IFACE}.service \
        ${PN}@${ALT_RMCPP_IFACE}.socket \
        "

ALT_RMCPP_IFACE_2 = "usb0"
SYSTEMD_SERVICE:${PN} += " \
    ${PN}@${ALT_RMCPP_IFACE_2}.service \
    ${PN}@${ALT_RMCPP_IFACE_2}.socket \
    "