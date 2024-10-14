FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit obmc-phosphor-systemd

SRC_URI:append = " file://psu.json"

PACKAGECONFIG:append = " monitor"

do_install:append(){
    install -D ${WORKDIR}/psu.json ${D}${datadir}/phosphor-power/psu.json
}
FILES:${PN}:append = " ${datadir}/phosphor-power/psu.json"

PSU_MONITOR_ENV_FMT = "obmc/power-supply-monitor/power-supply-monitor-{0}.conf"
OBMC_POWER_SUPPLY_INSTANCES = "0 1"
SYSTEMD_ENVIRONMENT_FILE:${PN}-monitor:append = " ${@compose_list(d, 'PSU_MONITOR_ENV_FMT', 'OBMC_POWER_SUPPLY_INSTANCES')}"
