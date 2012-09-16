#!/bin/bash
echo "---------------------------------------------------------------------------------
Nexus 7 Simple Root Bash Script (v1.2)		   
Made by @Complex360 (cyr0s (@Complex360) && brando56894)	   
---------------------------------------------------------------------------------"
echo
#checks if user is root
if [[ "$(whoami)" != 'root'  ]];then
  echo "This script must be run as root!"
  exit
fi
if [[ "$(uname -i)" = 'x86_64'  ]];then
  echo "PLEASE ENSURE YOU HAVE ia32-libs INSTALLED. IF YOU DO, PRESS [ENTER]"
  read yayornay
fi
#if fastboot and adb are installed on the system use those instead of the included binaries
if [[ -x /usr/bin/adb ]]
  then
    adblocation=/usr/bin/adb
    echo "Using fasboot binary in /usr/bin/"
  else
    adblocation=./files/adb
    #File permission fix - Thanks to Mark Lord
    sudo chmod a+rx files/adb
    echo "Fixed and using bundled adb"
fi

if [[ -x /usr/bin/fastboot ]]
  then
    fastbootlocation=/usr/bin/fastboot
    echo "Using fasboot binary in /usr/bin/"
   else
    fastbootlocation=./files/fastboot
    #File permission fix - Thanks to Mark Lord
    sudo chmod a+rx files/fastboot
    echo "Fixed and using bundled fastboot"
fi
echo "Checking adb presence..."
$adblocation version
echo "Go Settings > Developer Options and enable USB Debugging."
echo "Once you've done this, press [ENTER]"
read go
echo "Pushing SuperSU onto device..."
$adblocation push ./files/SuperSU.zip /sdcard/
echo "Pushed SuperSU onto device!"
echo "Rebooting Nexus 7..."
$adblocation reboot bootloader
echo "Would you like to unlock your device? (y or n)"
read unlock
if [[ $unlock == "y" ]]
  then
    $fastbootlocation oem unlock
    echo "Once you see a  android and \"Start\" on your device"
    echo "You will see a prompt offering to unlock the bootloader, select Yes."
    $fastbootlocation oem unlock
    echo "Once you get confirmation that the bootloader is unlocked, press [ENTER]..."
    read go2
fi
echo "Which recovery would you like to flash?"
echo "(c) ClockWorkMod Recovery"
echo "(t) Team Win Recovery Project v2.2.1.5"
read choice
echo
if [[ $choice == "c" ]]
  then
    echo "Flashing ClockWorkMod..."
    $fastbootlocation flash recovery ./files/clockworkmod.img
    echo "ClockWorkMod flashed with fastboot!"
    echo "Everything is done! to install SuperSU, load into CWM and choose it from the \"install zip from sdcard\" menu"
  else
    echo "Flashing TWRP..."
    $fastbootlocation flash recovery ./files/twrp-2.2.1.5.img
    echo "TWRP flashed with fastboot!"
    echo "Everything is done! to install SuperSU, load into TWRP and choose it from the \"install\" menu"
fi
