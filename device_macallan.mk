#
# tdro@github.com
#

# Defaults
$(call inherit-product, build/target/product/full.mk)
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)
$(call inherit-product-if-exists, vendor/kobo/macallan/macallan-vendor.mk)

# Overlays
DEVICE_PACKAGE_OVERLAYS += device/kobo/macallan/overlay

# Kernel Target
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := device/kobo/macallan/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

# Kernel Files
PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Root
PRODUCT_COPY_FILES += \
	device/kobo/macallan/fstab.macallan:root/fstab.macallan \
	device/kobo/macallan/ueventd.macallan.rc:root/ueventd.macallan.rc

# Init
PRODUCT_COPY_FILES += \
	device/kobo/macallan/init/init.macallan.rc:root/init.macallan.rc \
	device/kobo/macallan/init/init.macallan.usb.rc:root/init.macallan.usb.rc \
	device/kobo/macallan/init/init.recovery.macallan.rc:root/init.recovery.macallan.rc \
	device/kobo/macallan/init/init.tf.rc:root/init.tf.rc

# Adb Keys
PRODUCT_COPY_FILES += \
	device/kobo/macallan/adb_keys:root/adb_keys

# Audio Override
PRODUCT_COPY_FILES_OVERRIDES := \
	system/etc/audio_policy.conf \
	system/etc/media_codecs.xml \
	system/etc/media_profiles.xml

# Hardware Specific Features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.ethernet.xml:system/etc/permissions/android.hardware.ethernet.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml

# Default Overrides
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
	persist.sys.usb.config=mtp,adb

# Wifi Tools
PRODUCT_PACKAGES += \
	libwpa_client \
	hostapd \
	dhcpcd.conf \
	wpa_supplicant \
	wpa_supplicant.conf
	
# Filesystem Tools
	PRODUCT_PACKAGES += \
	make_ext4fs \
	setup_fs

# Audio Tools
PRODUCT_PACKAGES += \
	audio.a2dp.default \
	audio.usb.default \
	audio.r_submix.default

# Power
PRODUCT_PACKAGES += power.tegra

# Build Configs
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_AAPT_CONFIG := xlarge hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
