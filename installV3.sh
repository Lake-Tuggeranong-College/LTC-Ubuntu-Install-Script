# TODO:
# Add a paint program (Krita or GIMP?)
# Make Desktop Shortcuts -> https://www.linuxfordevices.com/tutorials/ubuntu/create-desktop-shortcuts-using-terminal & https://askubuntu.com/questions/1218954/desktop-files-allow-launching-set-this-via-cli
# Download VM images?? Done did not got rasp pi one
	# How to auto-configure virtualbox with these images?
	# Not possible, need to manually add all images
# Fix Desktop shortcut creation (Looks like it does not make a home directory???)
# Fix givng robo acc perms for USB/TTY (usergroup dialout does not exist)
# All apps need to avaliable on application menu
# Get PC number Via host name or user input, name logfile after pc nummber

# NOTES:
# Godot has updated 4.0 (We prob need to stay on 3.5.1 due to the fact that the scirpting language is not backwards compatable and Ryan has not updated tutorials yet)
# Snaps are stored in /var/lib/snapd/desktop/applications
# To list all users - awk -F: '{ print $1 }' /etc/passwd
# Cannot create 'admin' user in Ubuntu because it is already used, so offical user is now administrator
# Before starting script, log into each user to create their home directory
# PC name should be "6118-PCNUMBER"


#! /bin/sh

#Initialize logging terminal output and commands used
script screen.log
sudo apt update && sudo apt upgrade
sudo apt autoremove
sudo snap refresh
sudo apt --fix-missing -y update

#Add Users
sudo useradd -p $(openssl passwd -1 student) gamedev
sudo useradd -p $(openssl passwd -1 student) robotics
sudo useradd -p $(openssl passwd -1 student) cisco
usermod -aG sudo gamedev
usermod -aG sudo robotics
usermod -aG sudo cisco

#Install Apps
sudo add-apt-repository -y ppa:gns3/ppa
sudo apt install -y git
sudo apt install -y putty
sudo apt install -y putty-tools
sudo apt install -y blender
sudo apt install -y gimp
sudo apt install -y wireshark
sudo apt install -y ostinato
sudo apt install -y virtualbox
sudo apt install -y nmap
sudo apt install -y gns3-gui gns3-server
sudo snap install cirkit-designer
sudo snap install gd-godot-engine-snapcraft
sudo snap install code --classic
sudo snap install vlc
sudo snap install arduino
sudo snap install krita
#Download Chrome from the internet
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
# Install Chrome
sudo dpkg -i google-chrome-stable_current_amd64.deb 
#Download Github Desktop from the internet
wget https://github.com/shiftkey/desktop/releases/download/release-3.2.0-linux1/GitHubDesktop-linux-3.2.0-linux1.deb 
#Install Github Desktop
sudo apt install ./GitHubDesktop-linux-3.2.0-linux1.deb 
#Download Packet Tracer
wget 
#Install Packet Tracer
sudo apt install ./CiscoPacketTracer_821_Ubuntu_64bit.deb

#Create Desktop shortcuts 


#GameDev
	#Github
	cp /usr/share/applications/github-desktop.deskop /home/gamedev/Desktop
	gio set /home/gamedev/Desktop/github-desktop.deskop metadata::trusted true
	chmod a+x /home/gamedev/Desktop/github-desktop.deskop
	#Chrome
	cp /usr/share/applications/google-chrome.deskop /home/gamedev/Desktop
	gio set /home/gamedev/Desktop/google-chrome.deskop metadata::trusted true
	chmod a+x /home/gamedev/Desktop/google-chrome.deskop
	#Blender (May not need since Y11 never do 3D, may change for a paint program)
	cp /usr/share/applications/blender.deskop /home/gamedev/Desktop
	gio set /home/gamedev/Desktop/blender.deskop metadata::trusted true
	chmod a+x /home/gamedev/Desktop/blender.deskop
	#Godot
	cp /var/lib/snapd/desktop/applications/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop /home/gamedev/Desktop
	gio set /home/gamedev/Desktop/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop metadata::trusted true
	chmod a+x /home/gamedev/Desktop/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop
	#VS Code
	cp /var/lib/snapd/desktop/applications/code_code.desktop /home/gamedev/Desktop
	gio set /home/gamedev/Desktop/code_code.desktop metadata::trusted true
	chmod a+x /home/gamedev/Desktop/code_code.desktop

#Robo
	#Github
	cp /usr/share/applications/github-desktop.deskop /home/robotics/Desktop
	gio set /home/robotics/Desktop/github-desktop.deskop metadata::trusted true
	chmod a+x /home/robotics/Desktop/github-desktop.deskop
	#Chrome
	cp /usr/share/applications/google-chrome.deskop /home/robotics/Desktop
	gio set /home/robotics/Desktop/google-chrome.deskop metadata::trusted true
	chmod a+x /home/robotics/Desktop/google-chrome.deskop
	#VS Code
	cp /var/lib/snapd/desktop/applications/code_code.desktop /home/robotics/Desktop
	gio set /home/robotics/Desktop/code_code.desktop metadata::trusted true
	chmod a+x /home/robotics/Desktop/code_code.desktop
	#Arduino
	cp /var/lib/snapd/desktop/applications/arduino_arduino.desktop /home/robotics/Desktop
	gio set /home/robotics/Desktop/arduino_arduino.desktop metadata::trusted true
	chmod a+x /home/robotics/Desktop/arduino_arduino.desktop
	#Cirkit Designer
	cp /var/lib/snapd/desktop/applications/cirkit-designer_cirkit-designer.desktop /home/robotics/Desktop
	gio set /home/robotics/Desktop/cirkit-designer_cirkit-designer.desktop metadata::trusted true
	chmod a+x /home/robotics/Desktop/cirkit-designer_cirkit-designer.desktop

#CISCO #Need to install packet tracer manually, add shortcut to desktop, figure out how to put in application menu
	#Virtual Box
	cp /usr/share/applications/virtualbox.deskop /home/cisco/Desktop
	gio set /home/cisco/Desktop/virtualbox.deskop metadata::trusted true
	chmod a+x /home/cisco/Desktop/virtualbox.deskop
	#GNS3
	cp /usr/share/applications/gns3.deskop /home/cisco/Desktop
	gio set /home/cisco/Desktop/gns3.deskop metadata::trusted true
	chmod a+x /home/cisco/Desktop/gns3.deskop
	#Wireshark
	cp /usr/share/applications/org.wireshark.Wireshark.deskop /home/cisco/Desktop
	gio set /home/cisco/Desktop/org.wireshark.Wireshark.deskop metadata::trusted true
	chmod a+x /home/cisco/Desktop/org.wireshark.Wireshark.deskop
	#Google Chrome
	cp /usr/share/applications/google-chrome.deskop /home/cisco/Desktop
	gio set /home/cisco/Desktop/google-chrome.deskop metadata::trusted true
	chmod a+x /home/cisco/Desktop/google-chrome.deskop
	#PuttY
	cp /usr/share/applications/putty.deskop /home/cisco/Desktop
	gio set /home/cisco/Desktop/putty.deskop metadata::trusted true
	chmod a+x /home/cisco/Desktop/putty.deskop

#Grant Robo account perms to USB/TTY ports
sudo usermod -a -G dialout robotics

#Import VM images using VboxManage on 'cisco' user
su -l cisco
cd 

su -l administrator

#Check all packages again
sudo apt update && sudo apt upgrade
sudo apt autoremove
sudo snap refresh
sudo apt --fix-missing -y update

#Exit logging terminal state
exit

#Exit terminal after script is finished
exit

