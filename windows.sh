#!/bin/sh

sudo rmmod vboxnetflt vboxnetadp vboxpci vboxdrv

# -display sdl
# -boot d (boot cdrom)
# -serial stdio

exec sudo qemu-system-x86_64 --enable-kvm -cpu host -m 2048 -smp 3 \
-vga qxl \
-device qemu-xhci,id=xhci \
-device virtio-tablet,wheel-axis=true \
-device virtio-balloon \
-soundhw hda \
-netdev user,id=vmnic,smb=/temp \
-device virtio-net,netdev=vmnic \
-drive file=/usr/share/ovmf/x64/OVMF_CODE.fd,if=pflash,format=raw,unit=0,readonly=on \
-drive file=$HOME/.config/qemu-windows-puma.nvram,if=pflash,format=raw,unit=1 \
-drive file=/dev/sda,index=0,media=disk,driver=raw 
#-drive file=$HOME/Downloads/Win10_1809Oct_v2_English_x64.iso,media=cdrom
#-cdrom /opt/UefiShell.iso
