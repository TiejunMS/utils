[gen_raw_disk.sh](./gen_raw_disk.sh) is used to generate raw FAT disk.

## Environment
OS: Ubuntu
Install dosfstools.
  ```
  sudo apt-get update
  sudo apt-get install dosfstools
  ```

## Usage
```
./gen_raw_disk.sh <disk size by Kbytes> <disk image> <source directory>
```

### Example
Copy all files from [./root](./root/) to the root directory of raw disk.
```
./gen_raw_disk.sh 1024 disk.bin ./root
```

## Output
Once the raw disk is generated successfully, you can find the following output.
```
Disk image disk.bin is valid
```