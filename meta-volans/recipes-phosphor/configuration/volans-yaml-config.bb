SUMMARY = "YAML configuration for Volans"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch

SRC_URI = " \
    file://volans-ipmi-sensors.yaml \
    file://volans-ipmi-fru.yaml \
    file://volans-ipmi-fru-properties.yaml \
    "

S = "${WORKDIR}"

do_install() {
    install -m 0644 -D volans-ipmi-sensors.yaml \
        ${D}${datadir}/${BPN}/ipmi-sensors.yaml
    install -m 0644 -D volans-ipmi-fru.yaml \
        ${D}${datadir}/${BPN}/ipmi-fru-read.yaml
    install -m 0644 -D volans-ipmi-fru-properties.yaml \
        ${D}${datadir}/${BPN}/ipmi-extra-properties.yaml
}

FILES:${PN}-dev = " \
    ${datadir}/${BPN}/ipmi-sensors.yaml \
    ${datadir}/${BPN}/ipmi-fru-read.yaml \
    ${datadir}/${BPN}/ipmi-extra-properties.yaml \
    "

ALLOW_EMPTY:${PN} = "1"
