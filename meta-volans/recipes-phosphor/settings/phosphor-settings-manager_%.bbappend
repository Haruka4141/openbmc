FILESEXTRAPATHS:append := ":${THISDIR}/${PN}"
SRC_URI:append = " file://sol_default.override.yml \
                   file://power_on_hours.override.yml \
                   "
