# terminator
# chrome

# telegram

APPS_DIR="/home/"$(whoami)"/apps" 
mkdir -p $APPS_DIR 
cd $APPS_DIR

# sublime

echo "### Installing Sublime .."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text


# # Git
 echo "### Installing Git .."
 sudo apt-get install git -y

# # Terminator
 echo "### Installing Terminator .."
 sudo apt-get install terminator -y


# Slack
 echo "### Installing Slack (ver. 4.15.0 for newer update bash script) .."
 wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.15.0-amd64.deb
 sudo apt install -y ./slack-desktop-*.deb


# # Skype
 echo "### Installing Skype (latest) .."
 wget -nc https://repo.skype.com/latest/skypeforlinux-64.deb
 sudo apt install -y ./skypeforlinux-64.deb


# Vim and others
printf "### Installing Vim\n
FlameShot\n
okular"
sudo apt install -y vim flameshot okular


# Docker
echo "### Remove old versions of docker .."
sudo apt-get remove docker docker-engine docker.io containerd runc

echo "### Installing Docker .."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release 

# Copy gpg to /usr/share/keyrings/docker-archive-keyring.gpg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


echo "### Adding docker.list to /etc/apt/sources.list .."
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  focal stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo groupadd docker 
sudo usermod -aG docker sergey


# Docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


# Postman 
wget https://dl.pstmn.io/download/latest/linux64 -O Postman-linux-x64-latest.tar.gz
tar -xzf Postman-linux-x64-latest.tar.gz

echo "[Desktop Entry]
Name=Postman
Exec=${APPS_DIR}/Postman/Postman
Comment=
Terminal=false
Icon=${APPS_DIR}/Postman/app/resources/app/assets/icon.png
Type=Application" > ~/.local/share/applications/Postman
chmod +x ~/.local/share/applications/Postman

# создать ярлык
# sudo apt install -y ./skypeforlinux-64.deb

TODO:
Ссылки на яндекс.диск и mail облако в файловом менеджере 
яндекс-диск утилита

vlc
горячии клавиши для звука +/-

# Вручную
# echo "Вручную: 
# - Добавить апплет multi-core-system-monitor;"
# - горячие клавиши для flameshot; "
# - добавить shortcut copy/paste в terminator
# - ctrl+shift+t - вызов terminator
