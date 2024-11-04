#!/bin/bash

ENV_BMC_MAC_ADDR=$(echo $FQDN$RANDOM|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')
ENV_HOST_MAC_ADDR=$(echo $FQDN$RANDOM|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')

/usr/bin/usb-ctrl ecm usbnet on "$ENV_BMC_MAC_ADDR" "$ENV_HOST_MAC_ADDR"

# Use NCM (Ethernet) Gadget instead of FunctionFS Gadget
echo 0x0103 > /sys/kernel/config/usb_gadget/usbnet/idProduct
echo "OpenBMC usbnet Device" > /sys/kernel/config/usb_gadget/usbnet/strings/0x409/product
