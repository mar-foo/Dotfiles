#!/bin/sh
# MIT/X Consortium License

# © 2021 Mario Forzanini <mario.forzanini@studenti.unimi.it>

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Author: Mario Forzanini
# Date: 09/07/2021
# Bootstrap script to install Kiss Linux
# Assuming the disk has already been partitioned and you are already in a
# chroot

echo "Place to keep all the repos? [default: /var/repos/] (add trailing '/')"
read repo_path
mkdir -p ${repo_path:-"/var/repos"}
cd ${repo_path:-"/var/repos"}
git clone --depth=1 https://git.k1sslinux.org/kiss-community/repo
git clone --depth=1 https://git.k1sslinux.org/kiss-community/community
git clone --depth=1 https://git.k1sslinux.org/kiss-community/repo-bin bin

cat > ~/.profile <<EOF
#!/bin/sh
# Kiss repositories
export KISS_PATH=${repo_path:-"/var/repos/"}bin/bin
export KISS_PATH=\$KISS_PATH:${repo_path:-"/var/repos/"}repo/core
export KISS_PATH=\$KISS_PATH:${repo_path:-"/var/repos/"}repo/xorg
export KISS_PATH=\$KISS_PATH:${repo_path:-"/var/repos/"}repo/extra
export KISS_PATH=\$KISS_PATH:${repo_path:-"/var/repos/"}community/community
EOF

echo "Want to enable repository signing? (requires building gnupg1) [default: yes]"
read yn
case $yn in
    "[Yy](es)?","*") kiss b gnupg1
        gpg --keyserver keys.gnupg.net --recv-key DA4AB731D4C3F13D
        echo trusted-key DA4AB731D4C3F13D >> /root/.gnupg/gpg.conf
        cd /var/db/kiss/repo
        git config merge.verify.verifySignatures true
        break
        ;;
    "[Nn]o?") break
        ;;
esac

echo "Want to update? [default: no]"
read yn
case $yn in
    "[Yy](es)?") kiss update
        ;;
    "[Nn]o?","*") ;;
esac

echo "Installing ext4 filesystem tools"
kiss b e2fsprogs
echo "Installing libudev-zero"
kiss b libudev-zero
kiss b util-linux

echo "Do you need WiFi? [default: no]"
read yn
case $yn in
    "[Yy](es)?") kiss b wpa_supplicant
        ;;
    "[Nn]o?","*") ;;
esac
kiss b dhcpcd

echo "Hostname of the machine? [default: Kiss]"
read host
echo ${host:-"Kiss"} > /etc/hostname

wget https://marioforzanini.com/files/hosts
sed -i "s/HOSTNAME/${host:-"Kiss"}/" hosts
mv hosts /etc/hosts

echo "Setup kernel build, the directory will be called linux under /usr/src"
kiss b libelf ncurses links2
cd /usr/src/
mkdir linux
links https://linux-libre.fsfla.org/pub/linux-libre/releases/
cd linux
tar xvf ../linux-*
patch -p1 </usr/share/doc/kiss/wiki/kernel/patches/kernel-no-perl.patch
sed -i '/<stdlib.h>/a #include <linux/stddef.h>' tools/objtool/arch/x86/decode.c
wget https://www.marioforzanini.com/files/.config
make menuconfig
make -j$(nproc) && make INSTALL_MOD_STRIP=1 modules_install && make install

echo "Install bootloader"
kiss b grub

echo "Disk of installation? [default: /dev/sda]"
lsblk
while :; do
read disk
case "$disk" in
    "/dev/sd[a-z][0-9]+") if test -z "$(blkid | grep "$disk")"; then
        echo "$disk not found"
        lsblk
    else
        grub-install "$disk"
    fi
        ;;
        "*") lsblk
        ;;
esac
grub-mkconfig -o /boot/grub/grub.cfg

echo "Installing init scripts"
kiss b baseinit
sed -i '/username_here/a ::once:/bin/loadkmap </usr/share/bkeymaps/dvorak/dvorak.bmap' /etc/inittab

passwd root
echo "Add a user: [default: mario]"
read user
adduser ${user:-"mario"}

cd /home/${user:-"mario"}
su ${user:-"mario"} -c git clone https://git.marioforzanini.com/personalRepo
su ${user:-"mario"} -c wget https://marioforzanini.com/files/profile -O .profile
addgroup ${user:-"mario"} video
addgroup ${user:-"mario"} audio

su mario -
kiss b xorg-server xinit-xf86-input-libinput liberation-fonts \
    iosevka-nerd-fonts alsa-lib alsa-utils vim opendoas tmux fzf bkeymaps \
    mandoc man-pages-posix neomutt isync msmtp dwm st dmenu dotfiles

