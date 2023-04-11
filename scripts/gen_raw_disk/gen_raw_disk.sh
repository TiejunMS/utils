#!/bin/bash

# MIT License


# This script generates a raw disk image for the given disk size.
# And it also copies directory to the root of raw disk image.

# Set the mount point of the disk image
MNT_DIR=.mnt

usage() {
    echo "Usage: $0 <disk size by Kbytes> <disk image> <source directory>"
    echo "Example: $0 1024 disk.bin ./root"
    exit 1
}

# Check if mkfs.vfat is installed
if [ ! -x /sbin/mkfs.vfat ]; then
    echo "mkfs.vfat is not installed"
    echo "On Ubuntu, you can install it by running: sudo apt-get install dosfstools"
    exit 1
fi

# Check arguments
if [ $# -lt 3 ]; then
    usage
fi

# Check disk exists
if [ -f $2 ]; then
    echo "Disk image $2 already exists. Deleting..."
    rm -f $2
fi

# Create a binary file with the given size
dd if=/dev/zero of=$2 bs=1K count=$1 > /dev/null 2>&1

# Format the disk image to FAT
mkfs.vfat $2 > /dev/null

# Create the mount point
mkdir -p $MNT_DIR

# Mount the FAT disk image
sudo mount -t vfat $2 $MNT_DIR

# Copy files/directories to the root of the disk image
sudo cp -r $3/* $MNT_DIR

# Unmount the disk image
sudo umount $MNT_DIR

# Remove the mount point
rm -rf $MNT_DIR

# Validate the disk image
# Create the mount point
mkdir -p $MNT_DIR

# Mount the FAT disk image
sudo mount -t vfat $2 $MNT_DIR

# Diff the source directory and the root of the disk image
diff -r $3 $MNT_DIR > /dev/null 2>&1

# Check the return value
if [ $? -eq 0 ]; then
    echo "Disk image $2 is valid"
else
    echo "Disk image $2 is invalid"
fi

# Unmount the disk image
sudo umount $MNT_DIR

# Remove the mount point
rm -rf $MNT_DIR