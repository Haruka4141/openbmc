DEPENDS:append = " volans-yaml-config"

EXTRA_OEMESON = " \
    -Dsensor-yaml-gen=${STAGING_DIR_HOST}${datadir}/volans-yaml-config/ipmi-sensors.yaml \
    -Dfru-yaml-gen=${STAGING_DIR_HOST}${datadir}/volans-yaml-config/ipmi-fru-read.yaml \
    "
