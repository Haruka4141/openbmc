FILESEXTRAPATHS:append := ":${THISDIR}/${PN}"
SRC_URI:append = " file://volans_motherboard.json \
                   file://volans_chassis.json"

do_install:append() {
     rm -f ${D}${datadir}/entity-manager/configurations/*.json
     install -d ${D}${datadir}/entity-manager/configurations
     install -m 0444 ${WORKDIR}/volans_motherboard.json ${D}${datadir}/entity-manager/configurations
     install -m 0444 ${WORKDIR}/volans_chassis.json ${D}${datadir}/entity-manager/configurations
}