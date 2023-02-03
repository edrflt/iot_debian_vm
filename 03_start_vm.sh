#!/bin/sh

qemu-system-x86_64 -cdrom debian-11.5.0-amd64-netinst.iso \
		-hda iot.qcow2 \
		-enable-kvm \
		-machine q35 \
		-cpu host \
		-m 12G \
		-smp $(nproc) \
		-net user,hostfwd=tcp::5000-:22,hostfwd=tcp::8080-:80 \
		-net nic
