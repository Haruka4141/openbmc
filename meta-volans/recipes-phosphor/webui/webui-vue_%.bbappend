FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"
SRC_URI += "file://aic-logo.svg"

do_compile:prepend() {
    cp ${WORKDIR}/aic-logo.svg  ${S}/src/assets/images/login-company-logo.svg
}