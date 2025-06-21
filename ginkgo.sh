#!/bin/bash

# Automatic cleanup
echo "Performing cleanup..."
rm -rf .repo/local_manifests/
rm -rf device/xiaomi
rm -rf kernel/xiaomi
rm -rf vendor/xiaomi
rm -rf vendor/voltage
echo "Cleanup completed."
echo ""

# Initialize the ROM source repository
repo init -u https://github.com/DerpFest-LOS/android_manifest.git -b 15.2 --git-lfs
if [ $? -ne 0 ]; then
    echo "Repo initialization failed. Exiting."
    exit 1
fi
echo "================="
echo "Repo init success"
echo "================="
echo ""

# Clone local manifests
git clone https://github.com/Miracleprjkt/vendor_voltage vendor/voltage --depth=1
git clone https://github.com/Miracleprjkt/android_device_xiaomi_ginkgo device/xiaomi/ginkgo --depth=1
git clone https://github.com/Miracleprjkt/android_device_xiaomi_sm6125-common device/xiaomi/sm6125-common --depth=1
git clone https://github.com/LineageOS/android_kernel_xiaomi_sm6125 kernel/xiaomi/sm6125 --depth=1
git clone https://github.com/Skyblueborb/proprietary_vendor_xiaomi_ginkgo vendor/xiaomi/ginkgo --depth=1
git clone https://github.com/Skyblueborb/proprietary_vendor_xiaomi_sm6125-common vendor/xiaomi/sm6125-common --depth=1
if [ $? -ne 0 ]; then
    echo "Failed to clone tree source. Exiting."
    exit 1
fi
echo "============================"
echo "Tree Source clone success"
echo "============================"
echo ""

# Sync the repositories using the Crave sync script
/opt/crave/resync.sh
if [ $? -ne 0 ]; then
    echo "Crave sync failed. Exiting."
    exit 1
fi
echo "============================"
echo "Crave sync success"
echo "============================"
echo ""

# Drop Priv-Keys Voltage
rm -rf vendor/voltage-priv
echo "============================"
echo "Remove The Keys success"
echo "============================"
echo ""

# Build environment setup
. build/envsetup.sh
export BUILD_USERNAME=F4T3
export BUILD_HOSTNAME=Miracleprjkt
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

# Build the ROM
lunch lineage_ginkgo-bp1a-userdebug
if [ $? -ne 0 ]; then
    echo "Build failed. Exiting."
    exit 1
fi

mka derp
if [ $? -ne 0 ]; then
    echo "Installclean failed. Exiting."
    exit 1
fi

echo "============================"
echo "Build process completed successfully!"
echo "============================"

# Upload ROM zip file to PixelDrain
ROM_DIR="out/target/product/ginkgo/"
ROM_NAME=$(ls $ROM_DIR | grep "*.zip$" | tail -n 1)

if [ -n "$ROM_NAME" ]; then
    ROM_PATH="$ROM_DIR$ROM_NAME"
    echo "Uploading ROM file to PixelDrain..."
    curl -T "$ROM_PATH" -u :3e3790b9-84ab-46c4-b723-34e18eb70879 https://pixeldrain.com/api/file/
    if [ $? -eq 0 ]; then
        echo "ROM uploaded successfully to PixelDrain!"
    else
        echo "Failed to upload ROM to PixelDrain. Check your network or credentials."
    fi
else
    echo "ROM file not found. Upload skipped."
fi

echo "============================"
echo "Script completed!"
echo "============================"
