SUMMARY = "Uboot ENV manager"
DESCRIPTION = "Utility to write Uboot ENV"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"
DEPENDS += " \
  boost \
  sdbusplus \
  systemd \
  phosphor-dbus-interfaces \
  phosphor-logging \
  "
SRCREV = "516faacd7f8d224f15cc041cc486290b43cf4911"

PV = "0.1+git${SRCPV}"

SRC_URI = "git://github.com/openbmc/phosphor-u-boot-env-mgr.git;protocol=https;branch=master"

S = "${WORKDIR}/git"
SYSTEMD_SERVICE:${PN} += "xyz.openbmc_project.U_Boot.Environment.Manager.service"

inherit pkgconfig meson systemd
