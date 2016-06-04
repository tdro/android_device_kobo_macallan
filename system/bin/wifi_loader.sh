#!/system/bin/sh

# Copyright (c) 2012-2013, NVIDIA CORPORATION.  All rights reserved.
#
# NVIDIA CORPORATION and its licensors retain all intellectual property
# and proprietary rights in and to this software, related documentation
# and any modifications thereto.  Any use, reproduction, disclosure or
# distribution of this software and related documentation without an express
# license agreement from NVIDIA CORPORATION is strictly prohibited.

if [ $(getprop ro.boot.commchip_id) -gt 0 ]; then
	echo "setting user configured value of WiFi chipset"
	setprop wifi.commchip_id $(getprop ro.boot.commchip_id)
	exit
fi
# vendor id defines
BRCM=0x02d0
TI=0x0097
MRVL=0x02df
brcm_symlink=y

#find hardware used and assigned corresponding mmc interface used for wifi chip
mmc=mmc1

vendor=$(cat /sys/bus/sdio/devices/$mmc:0001:1/vendor)
device=$(cat /sys/bus/sdio/devices/$mmc:0001:1/device)
pcb_ver=$(cat /proc/sysinfo/pcb_ver)

vendor_device="$vendor"_"$device"

# bcm43241 multi country switch
country=$(cat /sys/bus/i2c/devices/i2c-0/0-0056/country)

#Read vendor and product idea enumerated during kernel boot
if [ -z "$(getprop persist.commchip_vendor)" ]; then
	/system/bin/log -t "wifiloader" -p i "persist.commchip_vendor not defined. Reading enumerated data"
	setprop persist.commchip_vendor $vendor
	setprop persist.commchip_device $device
fi
	/system/bin/log -t "wifiloader" -p i "Comm chip replaced by user. reset symlinks if needed"
	if [ $vendor = $BRCM ]; then
		/system/bin/rm /data/misc/wifi/firmware/fw_bcmdhd.bin
		/system/bin/rm /data/misc/wifi/firmware/fw_bcmdhd_apsta.bin
		/system/bin/rm /data/misc/wifi/firmware/nvram.txt
		/system/bin/rm /data/misc/wifi/firmware/firmware_path
		/system/bin/rm /data/misc/bluetooth/bcm43241.hcd
	fi
	setprop persist.commchip_vendor $vendor
	setprop persist.commchip_device $device

#Find device and set configurations
#broadcomm comm chip
if [ $vendor = $BRCM ]; then
	if [ $device = "0x4324" ]; then
		/system/bin/log -t "wifiloader" -p i  "BCM43241 chip identified"
		chip="43241"
	fi

	if [ $brcm_symlink = y ]; then
		if [ $pcb_ver = "EVT" ]; then
			/system/bin/ln -s /system/vendor/firmware/bcm$chip/fw_bcmdhd_$pcb_ver.bin /data/misc/wifi/firmware/fw_bcmdhd.bin
			/system/bin/ln -s /system/vendor/firmware/bcm$chip/fw_bcmdhd_$pcb_ver.bin /data/misc/wifi/firmware/fw_bcmdhd_apsta.bin
			/system/bin/ln -s /system/etc/nvram_$chip"_"$pcb_ver.txt /data/misc/wifi/firmware/nvram.txt
		else
			/system/bin/ln -s /system/vendor/firmware/bcm$chip/fw_bcmdhd.bin /data/misc/wifi/firmware/fw_bcmdhd.bin
			/system/bin/ln -s /system/vendor/firmware/bcm$chip/fw_bcmdhd.bin /data/misc/wifi/firmware/fw_bcmdhd_apsta.bin
				echo "Set the country for the "	$country
				case $country in
				AU)
				echo	"country is [Australia]"
				/system/bin/ln -s /system/etc/nvram_$chip"_"$country.txt /data/misc/wifi/firmware/nvram.txt
				;;
				NZ)
				echo	"country is [New Zealand]"
				/system/bin/ln -s /system/etc/nvram_$chip"_"$country.txt /data/misc/wifi/firmware/nvram.txt
				;;
				CA)
				echo	"country is [Canada]"
				/system/bin/ln -s /system/etc/nvram_$chip"_"$country.txt /data/misc/wifi/firmware/nvram.txt
				;;
				EU)
				echo	"country is [Europe]"
				/system/bin/ln -s /system/etc/nvram_$chip"_"$country.txt /data/misc/wifi/firmware/nvram.txt
				;;
				HK)
				echo	"country is [Hong Kong]"
				/system/bin/ln -s /system/etc/nvram_$chip"_"$country.txt /data/misc/wifi/firmware/nvram.txt
				;;
				JP)
				echo	"country is [Japan]"
				/system/bin/ln -s /system/etc/nvram_$chip"_"$country.txt /data/misc/wifi/firmware/nvram.txt
				;;
				US)
				echo	"country is [United States]"
				/system/bin/ln -s /system/etc/nvram_$chip"_"$country.txt /data/misc/wifi/firmware/nvram.txt
				;;
				*)
				echo	"country is [ALL]"
				/system/bin/ln -s /system/etc/nvram_$chip"_ALL".txt /data/misc/wifi/firmware/nvram.txt
				;;
				esac
		fi
		if [ $pcb_ver = "EVT" ]; then
		/system/bin/ln -s /system/etc/firmware/bcm$chip"_"$pcb_ver.hcd /data/misc/bluetooth/bcm$chip.hcd
		else
		/system/bin/ln -s /system/etc/firmware/bcm$chip.hcd /data/misc/bluetooth/bcm$chip.hcd
		fi
	fi
	insmod /system/lib/modules/cfg80211.ko
	if [  $chip = "43241" ]; then
		insmod /system/lib/modules/bcm43241.ko
		/system/bin/ln -s /sys/module/bcm43241/parameters/firmware_path /data/misc/wifi/firmware/firmware_path
	else
		insmod /system/lib/modules/bcmdhd.ko
		/system/bin/ln -s /sys/module/bcmdhd/parameters/firmware_path /data/misc/wifi/firmware/firmware_path
	fi
	setprop wifi.supplicant wpa_suppl_nl
fi

#increase the wmem default and wmem max size
echo 262144 > /proc/sys/net/core/wmem_default
echo 262144 > /proc/sys/net/core/wmem_max

#sleep for -1 timeout, so that wifiloader can be run as daemon
sleep 2147483647
