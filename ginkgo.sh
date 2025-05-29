#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi

repo init --depth=1 --no-repo-verify -u https://github.com/Los-Ext/manifest.git -b 15 --git-lfs -g default,-mips,-darwin,-notdefault

/opt/crave/resync.sh

git clone https://github.com/Miracleprjkt/device_xiaomi_ginkgo -b LinegExt-22.2 device/xiaomi/ginkgo

git clone https://github.com/kutemeikito/vendor_xiaomi_ginkgo -b fourteen vendor/xiaomi/ginkgo

git clone https://github.com/Miracleprjkt/Signing_Keys vendor/lineage-priv/keys

git clone https://github.com/mipa-ginkgo/android_vendor_miuicamera vendor/miuicamera

git clone https://github.com/LineageOS/android_hardware_qcom-caf_common -b lineage-21.0 hardware/qcom-caf/common

git clone https://github.com/kutemeikito/android_kernel_xiaomi_ginkgo -b fourteen/main kernel/xiaomi/ginkgo

git clone https://gitlab.com/kutemeikito/rastamod69-clang -b clang-20.0 prebuilts/clang/host/linux-x86/clang-rastamod

rm -rf hardware/qcom-caf/sm8150/display

git clone https://github.com/crdroidandroid/android_hardware_qcom_display -b 14.0-caf-sm8150 hardware/qcom-caf/sm8150/display

. build/envsetup.sh

lunch lineage_ginkgo-userdebug

mka bacon
