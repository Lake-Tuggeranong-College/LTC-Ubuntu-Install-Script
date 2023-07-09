# TODO:
# All apps need to avaliable on application menu
# Find a way to automate VMware VIX install (Shows a popup that the user needs to click through)

# NOTES:
# Test of Script on 23/5: Could not test automount of drives due to incorect config with VM (Will test at a later date), Some install lines were missing the -y flag
# Test of Scipt on 25/5: Mkfs came up with comfermation popup, may have fixed it with ereaseing it first

#! /bin/bash


#Setup one of the HDD to use as the location of the user home folders
echo Do you need multi drive setup?
read selection

if [ $selection = Y ] || [ $selection = y ]
then
sudo mkfs.ext4 /dev/sda
sudo mkdir /mnt/homeFolders
sdaUUID=$(sudo blkid -s UUID -o value /dev/sda)
echo UUID=$sdaUUID /home ext4 defaults  0  2 | sudo tee -a /etc/fstab
fi

#Mount drive so we can use homefolders
sudo mv /home /oldHome
sudo mkdir /home
sudo mount /dev/sda /home
sudo mv /oldHome/tigerteam /home

#Add Users
sudo useradd -m -p $(openssl passwd -1 student) -s /bin/bash gamedev
sudo useradd -m -p $(openssl passwd -1 student) -s /bin/bash robotics
sudo useradd -m -p $(openssl passwd -1 student) -s /bin/bash cisco
sudo useradd -m -p $(openssl passwd -1 student) -s /bin/bash webdev

#Put all users into sudo group
sudo usermod -aG sudo gamedev
sudo usermod -aG sudo robotics
sudo usermod -aG sudo cisco
sudo usermod -aG sudo webdev


# Update and upgrade packages from apt and snap
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo snap refresh
sudo apt --fix-missing -y update



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
sudo snap install gd-godot-engine-snapcraft
sudo snap install cirkit-designer
sudo snap install code --classic
sudo snap install vlc
sudo snap install arduino
sudo snap install krita
 
#Get and install VMware VIX (Needed to use GNS3)
sudo wget https://download3.vmware.com/software/player/file/VMware-VIX-1.17.0-6661328.x86_64.bundle -P /tmp
sudo chmod a+x /tmp/VMware-VIX-1.17.0-6661328.x86_64.bundle
sudo /tmp/VMware-VIX-1.17.0-6661328.x86_64.bundle
 
#Download & Install Chrome from the internet
sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -P /tmp
sudo dpkg -i /tmp/google-chrome-stable_current_amd64.deb 
 
#Download & Install Github Desktop from the internet
sudo wget https://github.com/shiftkey/desktop/releases/download/release-3.2.0-linux1/GitHubDesktop-linux-3.2.0-linux1.deb -P /tmp
sudo apt install /tmp/GitHubDesktop-linux-3.2.0-linux1.deb 
 
#Download Packet Tracer
sudo wget https://bit.ly/3zNcdQ5 -P /tmp
#Add .deb to the end of install file
sudo mv /tmp/3zNcdQ5 /tmp/3zNcdQ5.deb
#Install Packet Tracer
sudo apt install -y /tmp/3zNcdQ5.deb
 
#Download & Install VNC Viewer
sudo wget https://downloads.realvnc.com/download/file/viewer.files/VNC-Viewer-7.1.0-Linux-x64.deb -P /tmp
sudo apt install -y /tmp/VNC-Viewer-7.1.0-Linux-x64.deb



#Cleanup downloads from internet
sudo rm /tmp/google-chrome-stable_current_amd64.deb
sudo rm /tmp/3zNcdQ5.deb
sudo rm /tmp/GitHubDesktop-linux-3.2.0-linux1.deb 
sudo rm /tmp/VMware-VIX-1.17.0-6661328.x86_64.bundle

#Check all packages again
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo snap refresh
sudo apt --fix-missing -y update
sudo apt upgrade -y

#Install Nvidia Drivers and force OS to use GPU
sudo apt install nvidia-driver-525 -y
sudo prime-select nvidia

#Add First Time User Setup and make it launch on login
sudo wget -O /etc/profile.d/FirstTimeUserSetup https://www.bit.ly/LTC-User-Setup
sudo touch /etc/profile.d/startSetup.sh
echo "IsSetup=~/.config/setupDone; if [ ! -f \"\$IsSetup\" ]; then gnome-terminal -- bash -c \"sh /etc/profile.d/FirstTimeUserSetup; exec bash\"; fi" | sudo tee /etc/profile.d/startSetup.sh

#Deletes PostInstall Downloader and Launcher
sudo rm /etc/profile.d/PostInstall.sh

#Exit & Reboot for Nvidia Driver
reboot