#!/bin/bash

IMAGE_FILE=$1"/bios.bin"

# SPI Get Link name
# SPI_DEV=$(find /sys/bus/spi/devices/ -type l -exec sh -c 'readlink "$1" | grep -q "1e630000.spi" && basename "$1"' _ {} \;)
SPI_DEV="spi1.0"    # Only update CS0
SPI_PATH="/sys/bus/spi/drivers/spi-nor"

power_status() {
	st=$(busctl get-property xyz.openbmc_project.State.Chassis /xyz/openbmc_project/state/chassis0 xyz.openbmc_project.State.Chassis CurrentPowerState | cut -d"." -f6)
	if [ "$st" == "On\"" ]; then
		echo "on"
	else
		echo "off"
	fi
}

set_gpio()
{
    local pin_info
    read -r -a pin_info < <(gpiofind "$1")
    gpioset "${pin_info[0]}" "${pin_info[1]}"="$2"
}

set_gpio_to_bmc()
{
    echo "switch bios GPIO to bmc"
    # bbios_spi_mux: 0:BMC / 1:CPU
    set_gpio bios_spi_mux 0
    return 0
}

set_gpio_to_cpu()
{
    echo "switch bios GPIO to CPU"
    # bios_spi_mux: 0:BMC / 1:CPU
    set_gpio bios_spi_mux 1
    return 0
}

echo "Bios upgrade started at $(date)"

#Power off host server.
# echo "Power off host server"
# power_off
sleep 15
if [ "$(power_status)" != "off" ];
then
    echo "Host server didn't power off"
    echo "Bios upgrade failed"
    exit 1
fi
echo "Host server powered off"

#Flip GPIO to access SPI flash used by host.
echo "Set GPIO bios_spi_mux to access SPI flash from BMC used by host"
set_gpio_to_bmc

#Bind spi driver to access flash
echo "bind aspeed-smc spi driver"
echo -n "$SPI_DEV" > "$SPI_PATH"/bind
sleep 1

#Flashcp image to device.
if [ -e "$IMAGE_FILE" ];
then
    echo "Bios image is $IMAGE_FILE"
    for d in mtd7; do   # Only update CS0
        if [ -e "/dev/$d" ]; then
            mtd=$(cat /sys/class/mtd/$d/name)
            if [ "$mtd" == "pnor" ]; then
                echo "Flashing bios image to $d..."
                if flashcp -v "$IMAGE_FILE" /dev/$d; then
                    echo "bios updated successfully..."
                else
                    echo "bios update failed..."
                fi
                break
            fi
            echo "$d is not a pnor device"
        fi
        echo "$d not available"
    done
else
    echo "Bios image $IMAGE_FILE doesn't exist"
fi

#Unbind spi driver
sleep 1
echo "Unbind aspeed-smc spi driver"
echo -n "$SPI_DEV" > "$SPI_PATH"/unbind
sleep 10

#Flip GPIO back for host to access SPI flash
echo "Set GPIO bios_spi_mux back for host to access SPI flash"
set_gpio_to_cpu
sleep 5
