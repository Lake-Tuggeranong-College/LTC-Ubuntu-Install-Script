#!/bin/bash

#Drop a script that laucnches term then runs first time setup scirpt in /etc/profile.d (Done in install script)
#When ran drop file in /.config of user home folder
#When about to start check for /.config file

IsSetup=~/.config/setupDone

if [ -f "$IsSetup" ]; then
	exit
fi

sudo

echo LTC Ubuntu User Setup

main() {
	echo 
	echo What Classes are you doing?
	echo 1. Game-Dev
	echo 2. Robotics
	echo 3. Web-Dev
	echo 4. Networking
	echo
	echo Please Select One Number You Will be able to select others later


	read varname

	if [ $varname = 1 ]
	then
		echo Adding Desktop Shortcuts for Game-Dev
		#Github
		cp /usr/share/applications/github-desktop.desktop ~/Desktop
		chmod +x ~/Desktop/github-desktop.desktop
		gio set ~/Desktop/github-desktop.desktop metadata::trusted true
		#Chrome
		cp /usr/share/applications/google-chrome.desktop ~/Desktop
		chmod +x ~/Desktop/google-chrome.desktop
		gio set ~/Desktop/google-chrome.desktop metadata::trusted true
		#Blender
		cp /usr/share/applications/blender.desktop ~/Desktop
		chmod +x ~/Desktop/blender.desktop
		gio set ~/Desktop/blender.desktop metadata::trusted true
		#Godot
		cp /var/lib/snapd/desktop/applications/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop ~/Desktop
		chmod +x ~/Desktop/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop
		gio set ~/Desktop/gd-godot-engine-snapcraft_gd-godot-engine-snapcraft.desktop metadata::trusted true
		#Code
		cp /var/lib/snapd/desktop/applications/code_code.desktop ~/Desktop
		chmod +x ~/Desktop/code_code.desktop.desktop
		gio set ~/Desktop/code_code.desktop.desktop metadata::trusted true
		#Kirta
		cp /var/lib/snapd/desktop/applications/krita_krita.desktop ~/Desktop
		chmod +x ~/Desktop/krita_krita.desktop
		gio set ~/Desktop/krita_krita.desktop metadata::trusted true
		#Gimp
		cp /usr/share/applications/gimp.desktop ~/Desktop
		chmod +x ~/Desktop/gimp.desktop
		gio set ~/Desktop/gimp.desktop metadata::trusted true

	
	elif [ $varname = 2 ]
	then
		echo Adding Desktop Shortcuts for Roborics
		#Chrome
		cp /usr/share/applications/google-chrome.desktop ~/Desktop
		chmod +x ~/Desktop/google-chrome.desktop
		gio set ~/Desktop/google-chrome.desktop metadata::trusted true
		#Github
		cp /usr/share/applications/github-desktop.desktop ~/Desktop
		chmod +x ~/Desktop/github-desktop.desktop
		gio set ~/Desktop/github-desktop.desktop metadata::trusted true
		#Arduino
		cp /var/lib/snapd/desktop/applications/arduino_arduino.desktop ~/Desktop
		chmod +x ~/Desktop/arduino_arduino.desktop
		gio set ~/Desktop/arduino_arduino.desktop metadata::trusted true
		#Cirkit-Designer
		cp /var/lib/snapd/desktop/applications/cirkit-designer_cirkit-designer.desktop ~/Desktop
		chmod +x ~/Desktop/cirkit-designer_cirkit-designer.desktop
		gio set ~/Desktop/cirkit-designer_cirkit-designer.desktop metadata::trusted true
		#Code
		cp /var/lib/snapd/desktop/applications/code_code.desktop ~/Desktop
		chmod +x ~/Desktop/code_code.desktop.desktop
		gio set ~/Desktop/code_code.desktop.desktop metadata::trusted true
		
		echo Giving User Account Access to USB/TTY Ports
		sudo usermod -a -G dialout $USER
	
	elif [ $varname = 3 ]
	then
		echo Adding Desktop Shortcuts for Web-Dev
		#Code
		cp /var/lib/snapd/desktop/applications/code_code.desktop ~/Desktop
		chmod +x ~/Desktop/code_code.desktop.desktop
		gio set ~/Desktop/code_code.desktop.desktop metadata::trusted true
		#Chrome
		cp /usr/share/applications/google-chrome.desktop ~/Desktop
		chmod +x ~/Desktop/google-chrome.desktop
		gio set ~/Desktop/google-chrome.desktop metadata::trusted true
		#Github
		cp /usr/share/applications/github-desktop.desktop ~/Desktop
		chmod +x ~/Desktop/github-desktop.desktop
		gio set ~/Desktop/github-desktop.desktop metadata::trusted true
		echo Downloading Jetbrains Toolbox and Dependencies
		sudo apt install -y libfuse2
		wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.28.1.15219.tar.gz
		tar -xr ~/jetbrains-toolbox-1.28.1.15219.tar.gz
		~/jetbrains-toolbox-1.28.1.15219/jetbrains-toolbox
	elif [ $varname = 4 ]
	then
		echo Adding Desktop Shortcuts for Networking
		#Putty
		cp /usr/share/applications/putty.desktop ~/Desktop
		chmod +x ~/Desktop/putty.desktop
		gio set ~/Desktop/putty.desktop metadata::trusted true
		#Chrome
		cp /usr/share/applications/google-chrome.desktop ~/Desktop
		chmod +x ~/Desktop/google-chrome.desktop
		gio set ~/Desktop/google-chrome.desktop metadata::trusted true
		#GNS3
		cp /usr/share/applications/gns3.desktop ~/Desktop
		chmod +x ~/Desktop/gns3.desktop
		gio set ~/Desktop/gns3.desktop metadata::trusted true
		#Wireshark
		cp /usr/share/applications/org.wireshark.Wireshark.desktop ~/Desktop
		chmod +x ~/Desktop/org.wireshark.Wireshark.desktop
		gio set ~/Desktop/org.wireshark.Wireshark.desktop metadata::trusted true
		#VBox
		cp /usr/share/applications/virtualbox.desktop ~/Desktop
		chmod +x ~/Desktop/virtualbox.desktop
		gio set ~/Desktop/virtualbox.desktop metadata::trusted true
		#VNC Viewer
		cp /usr/share/applications/realvnc-vncviewer.desktop ~/Desktop
		chmod +x ~/Desktop/realvnc-vncviewer.desktop
		gio set ~/Desktop/realvnc-vncviewer.desktop metadata::trusted true
		#Packet Tracer
		cp /opt/pt/packettracer ~/Desktop
		chmod +x ~/Desktop/packettracer
		echo Downloading and Importing VM images
		wget https://bit.ly/41qQCZO
		mv ./41qQCZO ./Raspberry_Pi_OS.ova
		wget https://bit.ly/3KTbmlM
		mv ./3KTbmlM ./Take-Home_CSC_Challenges.ova
		wget https://bit.ly/4402fJ5
		mv ./4402fJ5 ./Take-Home_CSC_Kali.ova
		vboxmanage import Raspberry_Pi_OS.ova
		vboxmanage import Take-Home_CSC_Challenges.ova
		vboxmanage import Take-Home_CSC_Kali.ova
	else
	
		echo
		echo Could Not Reconize Command. Please try again
		echo Press Enter to Retry
		read retry
		main
	fi
}

main


echo Do you have any other classes [Y/N]

read varname

if [ $varname = Y ] || [ $varname = y ]
then
main
fi

touch ~/.config/setupDone

echo First Time Setup done!
echo Fell free to delete the script off your desktop after this terminal window closes
echo Press Enter to Quit
read quit
exit
