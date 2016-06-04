#
# tdro@github.com
#

# Inherit From Proprietary Version
-include vendor/kobo/macallan/BoardConfigVendor.mk

# Architecture
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a15
ARCH_ARM_HAVE_TLS_REGISTER := true

# Board
TARGET_BOARD_PLATFORM := tegra
TARGET_BOOTLOADER_BOARD_NAME := macallan
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Audio
BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true

# Kernel
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_CMDLINE :=
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --base 10000000 --kernel_offset 00008000 --ramdisk_offset 01000000 --tags_offset 00000100
TARGET_PREBUILT_KERNEL := device/kobo/macallan/kernel

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR ?= device/kobo/macallan/bluetooth

# Graphics
BOARD_HAVE_PIXEL_FORMAT_INFO := true
BOARD_EGL_CFG := device/kobo/macallan/egl.cfg
USE_OPENGL_RENDERER := true

# PowerHAL
TARGET_POWERHAL_VARIANT := tegra

# Partition
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 8388608			#[8MB]
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 8388608		#[8MB]
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 805306368		#[768MB]
BOARD_USERDATAIMAGE_PARTITION_SIZE := 14329839616	#[13666MB]
BOARD_CACHEIMAGE_PARTITION_SIZE := 536870912		#[512MB]

# Recovery
RECOVERY_VARIANT := twrp
RECOVERY_FSTAB_VERSION := 2
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/pwm-backlight/brightness"
TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/bq27541-bat"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/class/android_usb/f_mass_storage/lun/file"
TARGET_RECOVERY_INITRC := device/kobo/macallan/recovery/init.rc

# Wifi
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd

WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_AP := "/vendor/firmware/bcm43241/fw_bcmdhd_apsta.bin"
WIFI_DRIVER_FW_PATH_STA := "/vendor/firmware/bcm43241/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P := "/vendor/firmware/bcm43241/fw_bcmdhd_p2p.bin"

# CM Hardware
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS := device/kobo/macallan/cmhw/

# Extended Fonts
EXTENDED_FONT_FOOTPRINT := true
