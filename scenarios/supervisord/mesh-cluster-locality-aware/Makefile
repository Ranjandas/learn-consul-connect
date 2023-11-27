pre:
	@echo "This scenario only works with Consul>=1.17.x"
	@echo "	* Ensure that you have Consul>=1.17.x installed"
	@echo "	* Run \"make network\", to prepare the loopback interface (sudo password required)"
	@echo "	* Run \"make certs\", to generate the required TLS certificates"

network:
	for x in `seq 10`; do sudo ifconfig lo0 alias 127.0.0.$$x; done

certs:
	mkdir -p config/certs
	cd config/certs ; consul tls ca create
	cd config/certs ; consul tls cert create -server

