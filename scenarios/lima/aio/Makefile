ifndef consul
override consul = 1.18
endif

ifndef nomad
override nomad = 1.7
endif

.PHONY=create, start, stop, destroy
create:
	limactl start hashibox.yaml --name srv01 --tty=false

start:
	limactl start srv01

stop:
	limactl stop srv01

destroy: stop
	limactl delete srv01
