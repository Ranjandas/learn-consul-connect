# Using multi-stage build for copying envoy binary from official docker image
FROM docker.io/envoyproxy/envoy:v1.20.3 as envoy


# Use Fedora 35 as the base image
FROM registry.fedoraproject.org/fedora:35

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
		   jq && \
    dnf clean all


# Install hey
ADD https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 /usr/local/bin/hey


# Copy Envoy binary from envoy docker image
COPY --from=envoy /usr/local/bin/envoy /usr/local/bin/envoy


# Install HashiCorp counting and dashboard binaries
RUN curl -sL https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/dashboard-service_linux_amd64.zip | zcat  >> /usr/local/bin/dashboard && \
    curl -sL https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/counting-service_linux_amd64.zip | zcat >> /usr/local/bin/counting && \
    chmod +x /usr/local/bin/dashboard && \
    chmod +x /usr/local/bin/counting


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
