# TODO:
# Make Desktop Shortcuts -> https://www.linuxfordevices.com/tutorials/ubuntu/create-desktop-shortcuts-using-terminal & https://askubuntu.com/questions/1218954/desktop-files-allow-launching-set-this-via-cli
# Automatically add VM's to Virtualbox
# Fix givng robo acc perms for USB/TTY (usergroup dialout does not exist)
# All apps need to avaliable on application menu
# Get PC number Via host name or user input, name logfile after pc nummber
# Make Desktop Folder in /etc/skel and move shortcuts into folder


# NOTES:
# Maybe turn off screen timeout since it stops the script, revert the change after its all done?
# Opened software centre to break "cannot lock cache" error at the first sudo apt upgrade
# Snaps are stored in /var/lib/snapd/desktop/applications
# To list all users - awk -F: '{ print $1 }' /etc/passwd
# Admin user is called tigerteam
# PC name should be "6118-PCNUMBER"
# Cannot create desktop/taskbar shortcuts that are launchable by default because Dbus cannot launch without display
# Computers have NVME ssd's, Laptops only have one HDD
# We should rollout image using PxE server. Using PC 14
# Clear TPM on all laptops and computers after new OS installed
# Priority for display ports on GPU is, DVI, HDMI, DP. Primary display (the one of the left) should be DVI or HDMI
# Enable remote desktop to allow management?


#! /bin/bash

#Initialize logging terminal output and commands used
sudo apt update && sudo apt upgrade -y
sudo apt autoremove
sudo snap refresh
sudo apt --fix-missing -y update

# Make User Desktop Folder
sudo mkdir /etc/skell/Desktop

#Add Users
sudo useradd -m -p $(openssl passwd -1 student) -s /bin/bash gamedev
sudo useradd -m -p $(openssl passwd -1 student) -s /bin/bash robotics
sudo useradd -m -p $(openssl passwd -1 student) -s /bin/bash cisco

#Put all users into sudo group
usermod -aG sudo gamedev
usermod -aG sudo robotics
usermod -aG sudo cisco

#Grant Robo account perms to USB/TTY ports
sudo usermod -a -G dialout robotics

#Install Various Apps
sudo add-apt-repository -y ppa:gns3/ppa
sudo apt install -y net-tools
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
sudo apt install -y godot3
sudo snap install cirkit-designer
sudo snap install code --classic
sudo snap install vlc
sudo snap install arduino
sudo snap install krita

#Get and install VMware VIX (Needed to use GNS3)
sudo wget https://download3.vmware.com/software/player/file/VMware-VIX-1.17.0-6661328.x86_64.bundle
sudo chmod a+x VMware-VIX-1.17.0-6661328.x86_64.bundle
sudo ./VMware-VIX-1.17.0-6661328.x86_64.bundle

#Download & Install Chrome from the internet
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo dpkg -i google-chrome-stable_current_amd64.deb 

#Download & Install Github Desktop from the internet
sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.2.0-linux1/GitHubDesktop-linux-3.2.0-linux1.deb 
sudo apt install ./GitHubDesktop-linux-3.2.0-linux1.deb 

#Download Packet Tracer
sudo wget https://bit.ly/3zNcdQ5
#Add .deb to the end of install file
sudo mv ./3zNcdQ5 ./3zNcdQ5.deb
#Install Packet Tracer
sudo apt install -y ./3zNcdQ5.deb

#Download & Install VNC Viewer
sudo wget https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-7.1.0-Linux-x64.deb
sudo apt install -y ./VNC-Viewer-7.1.0-Linux-x64.deb


#Create Desktop shortcuts 
	#GameDev
		#Github
		sudo cp /usr/share/applications/github-desktop.desktop /home/gamedev/Desktop
		sudo chmod a+x /home/gamedev/Desktop/github-desktop.desktop
		#Chrome
		sudo cp /usr/share/applications/google-chrome.desktop /home/gamedev/Desktop
		sudo chmod a+x /home/gamedev/Desktop/google-chrome.desktop
		#Blender (May not need since Y11 never do 3D, may change for a paint program)
		sudo cp /usr/share/applications/blender.deskop /home/gamedev/Desktop
		sudo chmod a+x /home/gamedev/Desktop/blender.desktop
		#Gimp
		sudo cp /usr/share/applications/gimp.deskop /home/gamedev/Desktop
		sudo chmod a+x /home/gamedev/Desktop/gimp.desktop
		#Godot
		sudo cp /var/lib/snapd/desktop/applications/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop /home/gamedev/Desktop
		sudo chmod a+x /home/gamedev/Desktop/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop
		#VS Code
		sudo cp /var/lib/snapd/desktop/applications/code_code.desktop /home/gamedev/Desktop
		sudo chmod a+x /home/gamedev/Desktop/code_code.desktop
		#Kirta
		sudo cp /var/lib/snapd/desktop/applications/krita_krita.desktop /home/gamedev/Desktop
		sudo chmod a+x /home/gamedev/Desktop/krita_krita.desktop

	#Robo
		#Github
		sudo cp /usr/share/applications/github-desktop.desktop /home/robotics/Desktop
		sudo chmod a+x /home/robotics/Desktop/github-desktop.desktop
		#Chrome
		sudo cp /usr/share/applications/google-chrome.deskop /home/robotics/Desktop
		sudo chmod a+x /home/robotics/Desktop/google-chrome.desktop
		#VS Code
		sudo cp /var/lib/snapd/desktop/applications/code_code.desktop /home/robotics/Desktop
		sudo chmod a+x /home/robotics/Desktop/code_code.desktop
		#Arduino
		sudo cp /var/lib/snapd/desktop/applications/arduino_arduino.desktop /home/robotics/Desktop
		sudo chmod a+x /home/robotics/Desktop/arduino_arduino.desktop
		#Cirkit Designer
		sudo cp /var/lib/snapd/desktop/applications/cirkit-designer_cirkit-designer.desktop /home/robotics/Desktop
		sudo chmod a+x /home/robotics/Desktop/cirkit-designer_cirkit-designer.desktop

	#CISCO
		#Virtual Box
		sudo cp /usr/share/applications/virtualbox.desktop /home/cisco/Desktop
		sudo chmod a+x /home/cisco/Desktop/virtualbox.desktop
		#GNS3
		sudo cp /usr/share/applications/gns3.desktop /home/cisco/Desktop
		sudo chmod a+x /home/cisco/Desktop/gns3.desktop
		#Wireshark
		sudo cp /usr/share/applications/org.wireshark.Wireshark.desktop /home/cisco/Desktop
		sudo chmod a+x /home/cisco/Desktop/org.wireshark.Wireshark.desktop
		#Google Chrome
		sudo cp /usr/share/applications/google-chrome.desktop /home/cisco/Desktop
		sudo chmod a+x /home/cisco/Desktop/google-chrome.desktop
		#PuttY
		sudo cp /usr/share/applications/putty.desktop /home/cisco/Desktop
		sudo chmod a+x /home/cisco/Desktop/putty.desktop
		#Packet Tracer
		sudo cp /opt/pt/packettracer /home/cisco/Desktop
		sudo chmod a+x /home/cisco/Desktop/packettracer

#Import VM images using VboxManage on 'cisco' user
su -l cisco
cd Downloads
sudo wget https://bit.ly/41qQCZO
sudo mv ./41qQCZO ./Raspberry_Pi_OS.ova
sudo wget https://bit.ly/3KTbmlM
sudo mv ./3KTbmlM ./Take-Home_CSC_Challenges.ova
sudo wget https://bit.ly/4402fJ5
sudo mv ./4402fJ5 ./Take-Home_CSC_Kali.ova
vboxmanage import Raspberry_Pi_OS.ova
vboxmanage import Take-Home_CSC_Challenges.ova
vboxmanage import Take-Home_CSC_Kali.ova
exit

#Cleanup downloads from internet
sudo rm google-chrome-stable_current_amd64.deb
sudo rm 3zNcdQ5.deb
sudo rm GitHubDesktop-linux-3.2.0-linux1.deb 
sudo rm VMware-VIX-1.17.0-6661328.x86_64.bundle

#Check all packages again
sudo apt update && sudo apt upgrade
sudo apt autoremove
sudo snap refresh
sudo apt --fix-missing -y update
sudo apt upgrade

#Install Nvidia Drivers and force OS to use GPU
sudo apt install nvidia-driver-525
sudo prime-select nvidia

#Exit & Reboot for Nvidia Driver
reboot

