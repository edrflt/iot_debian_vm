#!/bin/sh

qemu-img create -f qcow2 -o preallocation=off iot.qcow2 150G
