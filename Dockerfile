# Use Fedora 35 as the base image
FROM registry.fedoraproject.org/fedora:39

# Add HashiCorp Fedora YUM repository
ADD https://rpm.releases.hashicorp.com/fedora/hashicorp.repo /etc/yum.repos.d/

# Use fastest mirror available
RUN echo "fastestmirror=True" >> /etc/dnf/dnf.conf

# Install Consul and systemd (required for the init inside container)
RUN dnf install -y consul \
		   systemd \
		   tcpdump \
		   iproute \
		   bind-utils \
		   less \
		   jq \
		   procps-ng \
		   iptables \
		   hashicorp-envoy && \
    dnf clean all


# Install hey
ADD https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 /usr/local/bin/hey
RUN chmod +x /usr/local/bin/hey


# Install FakeService
RUN curl -sL https://github.com/nicholasjackson/fake-service/releases/download/v0.26.0/fake_service_linux_amd64.zip | zcat  >> /usr/local/bin/fake-service && \
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
