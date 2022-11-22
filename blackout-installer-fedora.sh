#!/bin/bash
#                                                                 ~Blackout Installer~
#                                                                   (Fedora Edition)
#
# Once you've downloaded this script open a terminal where you downloaded it.
# For example if the blackout-installer-fedora.sh is located in the Downloads folder 
# you can open a terminal and type " cd Downloads " (without the commas).
# You can type " ls " and press enter to confirm whether the file is located in the current directory or not.
# After that you must type " chmod +x blackout-installer-fedora.sh " into the terminal and press enter.
# Then you can run the script by typing " ./blackout-installer.sh " into the terminal (As previously without the commas)
# It will promt you for the super user password two times during installation, so please stay tuned!
#
# SPANISH:
# Una vez hayas descargado el script abre una terminal en el folder donde lo hayas descargado.
# Por ejemplo, si el archivo blackout-installer-fedora.sh está en descargas puedes 
# abrir la carpeta de descargas y hacer click derecho en la carpeta, luego 
# haz click en abrir en terminal. Una vez esté abierta la terminal puedes escribir " ls " sin las comas y presionar enter para observar si en verdad
# se encuentra el archivo blackout-installer-fedora.sh en dicha carpeta.
# Posteriormente puedes proceder a ejecutar el comando " chmod +x blackout-installer-fedora.sh "
# Finalmente puedes ejecutar el instalador escribiendo en la terminal el comando " ./blackout-installer-fedora.sh "
# Durante la ejecución del comando, se te pedirá que escribas tu contraseña dos veces, entonces por favor supervisa el proceso.
#
#This is designed for Fedora Linux
#Este script está diseñado para Fedora Linux

printf "\nWelcome to the Blackout Installer (Fedora Edition)\n"
sleep 3
clear
echo "  ... .... .    ............................    ...... .... 
 .::::.:::::::::::::::::::::::::::::::::::::::::::::::::::: 
 .:.-*+--:::-+*%@@@@@@@@@@@@-.::%@@@@@@@%@@@%#+::::-:-=:::: 
 .::::--::::.::-+#%@@@@@@@@@-.::@@@@@@@@@@%+-:..::::::::::: 
 .:::..::::::::..:-=*%@@@@@@-.::@@@@@@@@#-...:::::::..::::: 
 .:.+*=-:..::::::::::-+#@@@@-.::@@@@@@*-..:::::::..:-+%*.:: 
 .:.*@@@%*=:..::::::::::=*%@-.::@@@@+:..:::::::.:-+#@@@#.:: 
 .:.+@@@@@@%*=:..:::::::::-+-.::@@+:.:::::::..:=*%@@@@@#.:: 
 .:.+@@@@@@@@@%+:..:::::::::::::+:.:::::::..:=#@@@@@@@@#.:: 
 .:.+@@@@@@@@@@@@*-..:::::::::::..:::::::.:=#@@@@@@@@@@#.:: 
 .:.+@@@@@@@@@@@@@@#-..::::::::::::::::.:=#@@@@@@@@@@@@#.:: 
 .:.+@@@@@@@@@@@@@@@@*:.:::::::::::::..-#@@@@@@@@@@@@@@#.:: 
 .:.*@@@@@@@@@@@@@@@@@@+:::::::::::::-*@@@@@@@@@@@@@@@@#.:: 
 .:.+%%%%%%%%%%%%%%%%%@%-.:::::::::::=%@%%%%%%%%%%%%%%%*.:: 
 .:::..............::::..::::::::::::..:::.............:::: 
 .::::::::::::::::-:::::::::::::::::::::::-:-----------:::: 
 .:.+@@@@@@@@@@@@@*:::::::::::::::::.::::-#@@@@@@@@@@@@*.:: 
 .:.+@@@@@@@@@@@#-..:::::::.::::..:::::::::*@@@@@@@@@@@*.:: 
 .:.+@@@@@@@@@%=..:::::::.:=:..-*:.::-::::::=@@@@@@@@@@*.:: 
 .:.+@@@@@@@@+:.:::::::.:-*@-..:@%-.::-::::::-#@@@@@@@@*.:: 
 .:.+@@@@@@#-.::::::::.-*@@@-..-@@@+..:::::::::+%@@@@@@*.:: 
 .:.+@@@@@+..:::::::.:=%@@@@-..:@@@@#:.:::::::::-*@@@@@*.:: 
 .:.+@@@#:.::::::::.-*@@@@@@-..:@@@@@%=..:::::::::=%@@@*.:: 
 .:.+@%=..:::::::.:+%@@@@@@@-..-@@@@@@@*:.:::::::::-*@@*.:: 
 .:.+*:.:::::::..-#@@@@@@@@@-..:@@@@@@@@@=..:::::::::-#+.:: 
 .:::..:.::::..:+@@@@@@@@@@@-..:@@@@@@@@@@#-..::::::::::::: 
 .::::::::::::+%@@@@@@@@@@@@-..-@@@@@@@@@@@@*-::::::::::::: 
 .:::::---::-+#%############-..:############%*-:::::::::::: 
 .::::::::::::..............::::..............::::::::::::: 
 .........................................................."

sleep 3
printf "\nInstallation will begin now\n"

sleep 3
printf "\nAdding Flathub:\n"
#Adding Flathub as flatpak repo:
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

sleep 3
printf "\nImproving  the dnf config, installing repos and pkgs:\n"

sudo printf "\n#I added for speed\nfastestmirror=True\nmax_parallel_downloads=4\ndefaultyes=True\nkeepcache=True\n" >> /etc/dnf/dnf.conf

#/etc/dnf/dnf.conf
#[main]
#gpgcheck=1
#installonly_limit=3
#clean_requirements_on_remove=True
#best=False
#skip_if_unavailable=True

#I added for speed
#fastestmirror=True
#max_parallel_downloads=4
#defaultyes=True
#keepcache=True

#adding user to dialout group so that they can program development boards
touch dialout.sh
echo "sudo usermod -a -G dialout current" > ./dialout.sh
sed -i -e s/current/$(echo $(id -u -n))/g ./dialout.sh
chmod +x dialout.sh
sudo ./dialout.sh

#Creating and running the dnf script:

touch dnf.sh
echo "dnf update -y

dnf install kernel-tools -y
sed -i -e 's/performance/ondemand/g' /etc/sysconfig/cpupower
sed -i -e 's/schedutil/ondemand/g' /etc/sysconfig/cpupower

dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
  
dnf install \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
  
dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y

dnf install lame\* --exclude=lame-devel -y

dnf group upgrade --with-optional Multimedia -y

dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y

dnf groupupdate sound-and-video -y
dnf install rpmfusion-free-release-tainted -y
dnf install libdvdcss -y
dnf install rpmfusion-nonfree-release-tainted -y
dnf install \*-firmware -y
dnf group update core -y

dnf install ffmpeg vlc mpv mozilla-openh264 ufw wine htop neofetch cpufetch mozilla-ublock-origin.noarch bottles cheese libreoffice -y
dnf install fritzing ktechlab kicad geany thonny qalculate-gtk octave octave-control octave-signal -y
dnf install avr-binutils avr-gcc avr-gcc-c++ avr-libc avra avrdude -y

 " > dnf.sh
chmod +x ./dnf.sh
sudo ./dnf.sh

sleep 3
printf "\nInstalling some Flatpaks:\n"
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install com.github.tenderowl.frog -y
flatpak install org.onlyoffice.desktopeditors -y

#For Electronic Engineering
flatpak install cc.arduino.IDE2 -y
flatpak install com.github.alexhuntley.Plots -y
flatpak install io.github.ferraridamiano.ConverterNOW -y
flatpak install org.librepcb.LibrePCB -y
mkdir Elect
cd Elect
git clone https://gist.github.com/d64fda482a412f7af765079a24457702.git ./AVR
git clone https://gist.github.com/e84ac2c8b22dd07d490758f1bc69561d.git ./dsPIC
cd ~/

#Bashrc
git clone https://github.com/JDanielDBC/Blackout-Linux-Bashrc.git
rm ~/.bashrc
cp ./JDaniel-Bashrc/.bashrc ~/

printf "\nFinished installation\n"

rm -rf JDaniel-Bashrc
rm ./dialout.sh
rm ./dnf.sh
sleep 3

clear
echo "  ... .....          ....          ......... 
 ::==-::-=+*********+::=**********=::-:--::.
 ::-==-:::=+#@@@@@@@%::#@@@@@@@%+-::::::::: 
 ::-::..::..:-=#@@@@#::*@@@@@*-...::..:-=:. 
 .:#@#+-:..:::.:-+%@%::*@@%+:..:::.:-+#@@-..
 .:#@@@@%*-:.:::.::++::#@+:..:::.:=#@@@@%-..
 .:#@@@@@@@#=:.::::.:::-:.::::.:=#@@@@@@%-..
 .:#@@@@@@@@@%+:.::::::..:::.:=#@@@@@@@@%-..
 .:#@@@@@@@@@@@%=:::::::::::-#@@@@@@@@@@%-..
 .:%@@@@@@@@@@@@@*::::::::.+@@@@@@@@@@@@@-..
 ::-=---------===-::::::::::===-======-=-:: 
 ::=========++:...::::::::....-+=========:: 
 .:%@@@@@@@@%=:::::..::..:::::-#@@@@@@@@%:. 
 .:#@@@@@@%+:.::::.-=::+-.--::.:+@@@@@@@%:. 
 .:#@@@@@*:.::::.:+%%::%@+.:-::::=%@@@@@%:. 
 .:#@@@%=..:::..=%@@#::#@@*:.::::.:*@@@@%:. 
 .:#@@*:.::::.:*@@@@#::#@@@%=..:::::-#@@%:. 
 .:%%-..:::.:=%@@@@@#::#@@@@@*:.::::.:+%%:. 
 ::-:.:::..-#@@@@@@@#::#@@@@@@%=..:::.:-=:. 
 ::.::-::-*@@@@@@@@@%::%@@@@@@@@%=::::::::: 
 :::::-::-++++++++++=::=++++++++++:.::::::: "
printf "\n             ~Blackout Linux~\n"
sleep 1
printf "\nComplete! Your system is ready\n"
printf "\nCompletado! Tu sistema está listo\n"
