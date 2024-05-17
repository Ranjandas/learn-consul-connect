current_dir := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

ifndef consul
override consul = 1.18
endif

ifndef nomad
override nomad = 1.7
endif

.PHONY=create, start, stop, destroy
create:
	limactl start hashibox.yaml --name srv01 --set='. |= .images[0].location="file://$(current_dir)../../../packer/.artifacts/qemu/c-$(consul)-n-$(nomad)/c-$(consul)-n-$(nomad).qcow2"' --tty=false

start:
	limactl start srv01

stop:
	limactl stop srv01

destroy: stop
	limactl delete srv01
