#!/bin/bash

VM_USER=$1

mkdir -p /home/$VM_USER/Desktop
mkdir -p /home/$VM_USER/SfM

# Copy application shortcuts to the desktop
cp /usr/share/applications/lxterminal.desktop /home/$VM_USER/Desktop/
cp /usr/share/applications/meshlab.desktop /home/$VM_USER/Desktop/
cp /usr/share/applications/blender.desktop /home/$VM_USER/Desktop/

# Create a shortcut to course materials
cat > /home/$VM_USER/Desktop/course-materials.desktop << DELIM
[Desktop Entry]
Encoding=UTF-8
Name=Course Materials
GenericName=Course Materials
Comment=Shortcut to SfM course materials
Icon=folder
URL=/home/$VM_USER/SfM
Type=Link
DELIM

# Set the config file to update the wallpaper
mkdir -p /home/$VM_USER/.config/pcmanfm/lubuntu/
#cp /vagrant/VM/desktop-items-0.conf /home/$VM_USER/.config/pcmanfm/lubuntu/
cat > /home/$VM_USER/.config/pcmanfm/lubuntu/desktop-items-0.conf << DELIM
[*]
wallpaper_mode=stretch
wallpaper_common=1
wallpapers_configured=1
wallpaper=/usr/share/lubuntu/wallpapers/Desktop_KW.jpg
desktop_bg=#000000
desktop_fg=#ffffff
desktop_shadow=#000000
desktop_font=Ubuntu 11
show_wm_menu=0
sort=mtime;ascending;
show_documents=0
show_trash=0
show_mounts=0
DELIM

# Copy data files into the VM
WORK_DIR=/home/$VM_USER/SfM
cp -r /vagrant/Exercises $WORK_DIR/
cp -r /vagrant/Examples $WORK_DIR/
cp -r /vagrant/Data $WORK_DIR/

# make symlinks to CLIF images for MAP-Tk result viewing in Blender
cd /home/$VM_USER/SfM/Exercises/maptk/results
mkdir frames
cd frames
a=1
while read f
do
    ln -s ../../$f $(printf "%03d.jpg" "$a")
    let a=a+1
done < ../../clif_frames.txt

# copy user configuration files
cp -r /vagrant/VM/config/* /home/$VM_USER/.config
