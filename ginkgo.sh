#!/bin/bash

git clone https://github.com/Miracleprjkt/device_xiaomi_ginkgo -b PixelOS device/xiaomi/ginkgo

git clone https://github.com/Miracleprjkt/Vendor_Xiaomi_Ginkgo -b fourteen vendor/xiaomi/ginkgo

git clone https://github.com/LineageOS/android_hardware_qcom-caf_common -b lineage-21.0 hardware/qcom-caf/common

git clone https://github.com/tejas101k/kernel_xiaomi_ginkgo kernel/xiaomi/ginkgo

---------------------------------------------------------------------------------------------------------------------------
. build/envsetup.sh

lunch aosp_ginkgo-ap2a-userdebug

mka bacon -j(nproc --all)

-----------------------------------------------------------------------------------------------------------------------------