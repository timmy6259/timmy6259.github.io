#!/bin/bash

echo "Generating Packages File..."
dpkg-scanpackages -m debs /dev/null > Packages
bzip2 -c9 Packages > Packages.bz2

echo "Updating Release...."
cat <<EOF > Release
Origin: Timmy6259's Repo
Label: Timmy6259's Repo
Suite: stable
Version: 1.0
Codename: ios
Architectures: iphoneos-arm iphoneos-arm64
Components: main
Description: Timmy6259's custom jailbreak tweaks
Trusted: Yes
Key-Config: key.asc
EOF


echo "MD5Sum:" >> Release
echo " $(md5sum Packages | cut -d' ' -f1) $(wc -c < Packages) Packages" >> Release
echo " $(md5sum Packages.bz2 | cut -d' ' -f1) $(wc -c < Packages.bz2) Packages.bz2" >> Release

echo "SHA256:" >> Release
echo " $(sha256sum Packages | cut -d' ' -f1) $(wc -c < Packages) Packages" >> Release
echo " $(sha256sum Packages.bz2 | cut -d' ' -f1) $(wc -c < Packages.bz2) Packages.bz2" >> Release


echo "Creating Release.gpg..."
rm -f Release.gpg
gpg -abs -u 06BE2046A193DF5C -o Release.gpg Release

echo "Done."
