IPMI_FLASH_BMC_ADDRESS = "0x98000000"
PACKAGECONFIG:append = " aspeed-lpc net-bridge"
EXTRA_OEMESON:append = " -Dupdate-type=static-layout "