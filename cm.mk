#
# tdro@github.com
#

# Boot Animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_SCREEN_HEIGHT := 1600
TARGET_SCREEN_WIDTH := 2560

# Release name
PRODUCT_RELEASE_NAME := macallan

# Inherit device configuration
$(call inherit-product, device/kobo/macallan/device_macallan.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_tablet_wifionly.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := macallan
PRODUCT_NAME := cm_macallan
PRODUCT_BRAND := kobo
PRODUCT_MODEL := Kobo Arc 10HD
PRODUCT_MANUFACTURER := Kobo
