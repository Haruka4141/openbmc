FILESEXTRAPATHS:append:volans := ":${THISDIR}/${PN}"
SRC_URI:append:volans = " file://chassis_capabilities.override.yml"
SRC_URI:append:volans = " file://volans_settings.remove.yml"
