#!/bin/bash

set -x

export PATH=$HOME/proton-clang/bin:$PATH
export ARCH=arm64
export LINUX_COMPILE_BY="Anirudh"
export LINUX_COMPILE_HOST="vinimec"

ccache -M 2G
export USE_CCACHE=1
export CCACHE_EXEC=$(command -v ccache)

[ -d out ] && rm -rf out
make vendor/laurel_sprout-perf_defconfig O=out
make -j8 -k CC="ccache clang" O=out CROSS_COMPILE=aarch64-linux-gnu- CROSS_COMPILE_ARM32=arm-linux-gnueabi-
make -C AnyKernel3 clean

if [ "$?" == 0 ]; then
   cp $(pwd)/out/arch/arm64/boot/Image.gz-dtb $(pwd)/AnyKernel3
   cp $(pwd)/out/arch/arm64/boot/dtbo.img $(pwd)/AnyKernel3
   cd $(pwd)/AnyKernel3
   make -j8
   zipname=$(ls *.zip)
   url=$(curl --upload-file ./${zipname} https://transfer.sh/${zipname})
   echo -e "\nKernel Url:"
   echo "${url}"
   echo -e "\n"
   cd ..
fi
