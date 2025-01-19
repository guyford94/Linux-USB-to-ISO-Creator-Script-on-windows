# Linux USB to ISO Creator Script

This repository contains a batch script that allows you to create an ISO file from a Linux-formatted USB drive on a Windows 11 system. The script utilizes Windows Subsystem for Linux (WSL) and command-line tools like `dd` to capture the USB's content and store it as an ISO file.

## Features
- Lists all available drives in WSL for easy selection.
- Provides a graphical folder selection dialog for specifying the ISO output location.
- Uses the `dd` command in WSL to create an ISO file from the selected USB device.
- Ensures administrative privileges for operations requiring elevated permissions.
- Verifies user inputs and confirms actions before proceeding.

## Prerequisites
- **Windows 11** with WSL installed.
  - To install WSL, open a PowerShell terminal (as Administrator) and run:
    ```powershell
    wsl --install
    ```
- A Linux-compatible USB drive (e.g., ext4, ext3, or FAT32 formatted).
- The drive must be accessible in WSL (e.g., as `/dev/sdb`).

## Usage

### 1. Download the Script
Clone this repository or download the script file `create_linux_iso.bat` to your system.

### 2. Run as Administrator
Right-click the script file and select **Run as Administrator**. The script requires administrative privileges to access hardware devices and run `dd`.

### 3. Select the USB Device
The script will display all available drives in WSL using the `lsblk` command. Enter the WSL device name corresponding to your USB drive (e.g., `/dev/sdb`).

### 4. Choose an Output Folder
A File Explorer dialog will open, allowing you to select the destination folder where the ISO file will be saved.

### 5. Confirm the Operation
You must confirm the operation by typing "YES" when prompted. This prevents accidental data overwrites.

### 6. Wait for Completion
The script will use the `dd` command to create the ISO file and save it in the selected output folder. Progress will be displayed in the terminal.

### 7. ISO File Location
Once complete, the ISO file will be saved with the name `linux_usb_backup.iso` in the selected folder.

## Example Output

```plaintext
Listing drives using WSL...
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda      8:0    0 238.5G  0 disk
sdb      8:16   1   16.0G  0 disk

Select the WSL device name (e.g., /dev/sdb) from which you want to create an ISO file: /dev/sdb
Opening folder selection dialog...
You selected device: /dev/sdb
ISO file will be saved in: C:\Users\YourUsername\Documents
Type "YES" to confirm and proceed: YES
Creating ISO file from /dev/sdb...
Copying ISO file to the selected folder...
Operation complete. ISO file saved in C:\Users\YourUsername\Documents\linux_usb_backup.iso
