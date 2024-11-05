#!/bin/bash
rm -rf .repo/local_manifests
rm -rf device/infinix
rm -rf vendor/infinix
repo init -u https://github.com/LineageOS/android.git -b lineage-18.1 --git-lfs
/opt/crave/resync.sh

git clone https://github.com/Miracleprjkt/device_infinix_X657C -b los-18.1 device/infinix/X657C
git clone https://github.com/Infinix-MT6761D-Development/vendor_infinix_X657C vendor/infinix/X657C

export BUILD_USERNAME=Miracleprjkt
export BUILD_HOSTNAME=crave

source build/envsetup.sh
brunch X657C
