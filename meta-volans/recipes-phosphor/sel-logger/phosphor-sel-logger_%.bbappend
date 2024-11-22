FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://001-Add_SEL_into_IPMI&Redfish.patch"

PACKAGECONFIG:append = " log-threshold log-pulse log-alarm send-to-logger log-watchdog"
