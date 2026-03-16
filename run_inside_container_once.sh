# install poetry
poetry install

# fix locales
sudo su
apt update
apt install -y locales
sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
#apt install -y libncurses5
exit

# vitis-specific libs
sudo su
/mnt/labstore/Xilinx/Vitis/2024.2/scripts/installLibs.sh
exit

# clear xilinx ip cache
rm -rf ~/.Xilinx
rm -rf ~/.cache/Xilinx

vivado -mode tcl
exit
