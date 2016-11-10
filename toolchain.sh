#/bin/bash
echo "Removing existing directories..."
rm -r toolchain/aarch64-uber-5.3.1/
rm -r temp/
echo "Cloning toolchain..."
git clone "https://bitbucket.org/UBERTC/aarch64-linux-android-5.3-kernel.git" temp/
echo "Setting up folders"
mkdir toolchain/
cd toolchain/
mkdir aarch64-uber-5.3.1
cp -r ../temp/* aarch64-uber-5.3.1
echo "Cleaning up"
sudo rm -r ../temp

