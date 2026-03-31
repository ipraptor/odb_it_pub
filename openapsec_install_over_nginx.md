####### 1 INSTALL NGINX #######
#  0) See compability version OS and NGINX actual version OS Ubuntu = 22 (jammy)
#     https://downloads.openappsec.io/packages/supported-nginx.txt

#  1) unHold and clear trash
sudo apt-mark unhold nginx
sudo apt remove --purge nginx-dbg -y #без этого хуй вы поставите нужную вам версию

#  2) install NGINX
sudo apt install -y nginx=1.29.4-1~jammy

#  3) Fix and check version
sudo apt-mark hold nginx
nginx -v

####### INSTALL WAF #######
#  0) See Instruction mb useful
#     https://docs.openappsec.io/getting-started/start-with-linux/install-open-appsec-for-linux

#  1) Down and install
wget https://downloads.openappsec.io/open-appsec-install && chmod +x open-appsec-install
./open-appsec-install -h

###### STARTED WAF AGENT ######

# start agent
sudo open-appsec-ctl --start
sudo open-appsec-ctl --status

