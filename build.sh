#!/bin/bash
ROOT_DIR=$(pwd)
export ARCH=arm64
DEFCONFIG=falcon_gemini_defconfig
CROSS_COMPILER=$ROOT_DIR/toolchain/aarch64-uber-5.3.1/bin/aarch64-linux-android-
COMPILED=$ROOT_DIR/out
BUILDING_DIR=$COMPILED/kernel_obj
OUT_DIR=$COMPILED/output
mkdir $COMPILED $BUILDING_DIR $OUT_DIR
FUNC_CLEANUP()
{
	echo "Cleaning up..."
	rm -rf $BUILDING_DIR/*
	rm -rf $OUT_DIR/*
	echo "All clean!"
}

FUNC_COMPILE()
{
	echo "Starting the build..."
	make -C $ROOT_DIR O=$BUILDING_DIR $DEFCONFIG 
	make -C $ROOT_DIR O=$BUILDING_DIR ARCH=arm64 CROSS_COMPILE=$CROSS_COMPILER
	cp $COMPILED/kernel_obj/arch/arm64/boot/Image.gz-dtb $OUT_DIR/zImage
	echo "Job done!"
}

echo -n "Clean build directory (y/n)? "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$( while ! head -c 1 | grep -i '[ny]' ;do true ;done )
stty $old_stty_cfg
if echo "$answer" | grep -iq "^y" ;then
    FUNC_CLEANUP
    FUNC_COMPILE
else
    rm -r $OUT_DIR/zImage
    FUNC_COMPILE
fi


