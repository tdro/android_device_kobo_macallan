# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ifeq ($(TARGET_POWERHAL_VARIANT),tegra)

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := nvpowerhal.cpp timeoutpoker.cpp power.cpp powerhal_utils.cpp tegra_sata_hal.cpp

# This is only for devices that can contain a sata hard drive, currently only foster
ifneq ($(filter foster,$(TARGET_DEVICE)),)
LOCAL_CFLAGS += -DENABLE_SATA_STANDBY_MODE
endif

# Any devices with a old interactive governor
ifneq ($(filter roth,$(TARGET_DEVICE)),)
    LOCAL_CFLAGS += -DPOWER_MODE_LEGACY
endif

# Currently used only for T210 devices
ifneq ($(filter foster,$(TARGET_DEVICE)),)
    LOCAL_CFLAGS += -DPOWER_MODE_SET_INTERACTIVE
endif

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_SHARED_LIBRARIES := liblog libcutils libutils libdl

LOCAL_MODULE := power.$(TARGET_BOARD_PLATFORM)

LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

endif # TARGET_POWERHAL_VARIANT == tegra
