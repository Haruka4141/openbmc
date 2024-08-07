DEPENDS:append = " volans-yaml-config"

EXTRA_OEMESON = " \
    -Dsensor-yaml-gen=${STAGING_DIR_HOST}${datadir}/volans-yaml-config/ipmi-sensors.yaml \
    "
