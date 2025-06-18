#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi
rm -rf vendor/voltage

repo init -u https://github.com/VoltageOS/manifest.git -b 15-qpr2 --git-lfs

/opt/crave/resync.sh

git clone https://github.com/Miracleprjkt/vendor_voltage vendor/voltage

git clone https://github.com/Miracleprjkt/android_device_xiaomi_ginkgo device/xiaomi/ginkgo

git clone https://github.com/Miracleprjkt/android_device_xiaomi_sm6125-common device/xiaomi/sm6125-common

git clone https://github.com/LineageOS/android_kernel_xiaomi_sm6125 kernel/xiaomi/sm6125

git clone https://github.com/Skyblueborb/proprietary_vendor_xiaomi_ginkgo vendor/xiaomi/ginkgo

git clone https://github.com/Skyblueborb/proprietary_vendor_xiaomi_sm6125-common vendor/xiaomi/sm6125-common

rm -rf vendor/voltage-priv

. build/envsetup.sh
 
brunch ginkgo
