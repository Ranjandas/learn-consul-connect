# Use Fedora 35 as the base image
FROM registry.fedoraproject.org/fedora:39

ARG CONSUL_VERSION=1.17.2
ARG ENVOY_VERSION=1.27.2

# Add HashiCorp Fedora YUM repository
ADD https://rpm.releases.hashicorp.com/fedora/hashicorp.repo /etc/yum.repos.d/

# Use fastest mirror available
RUN echo "fastestmirror=True" >> /etc/dnf/dnf.conf

# Install Consul and systemd (required for the init inside container)
RUN dnf install -y consul-$CONSUL_VERSION \
		   systemd \
		   tcpdump \
		   iproute \
		   bind-utils \
		   less \
		   jq \
		   procps-ng \
		   iptables \
		   hashicorp-envoy-$ENVOY_VERSION \
		   httpd-tools && \
    dnf clean all


# Install FakeService
RUN curl -sL https://github.com/nicholasjackson/fake-service/releases/download/v0.26.2/fake_service_linux_$( [ $(uname -m) = aarch64 ] && echo arm64 || echo amd64).zip | zcat  >> /usr/local/bin/fake-service && \
    chmod +x /usr/local/bin/fake-service


# Copy all the systemd unit files 
COPY ./systemd/*.service /etc/systemd/system/


# Enable Consul, Dashboard, Counting and Envoy services
RUN systemctl enable consul \
			dashboard \
			counting \
			envoy-counting \
			envoy-dashboard \
			envoy-ingress \
			envoy-terminating \
			envoy-mesh


# Use systemd as command
CMD ["/usr/sbin/init"]
