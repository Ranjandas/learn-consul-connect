certs:
	@mkdir -p certs/dc1
	@mkdir -p certs/dc2
	@docker run -it --rm --workdir /tmp/certs -v `pwd`/certs:/tmp/certs hashicorp/consul tls ca create
	@docker run -it --rm --workdir /tmp/certs -v `pwd`/certs:/tmp/certs hashicorp/consul tls cert create -dc dc1 -server -node consul-server-dc1
	@docker run -it --rm --workdir /tmp/certs -v `pwd`/certs:/tmp/certs hashicorp/consul tls cert create -dc dc2 -server -node consul-server-dc2
	@mv certs/dc1*.pem certs/dc1/
	@mv certs/dc2*.pem certs/dc2/


clean:
	@rm -rf certs

