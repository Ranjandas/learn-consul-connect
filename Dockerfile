FROM docker.io/envoyproxy/envoy:v1.20.3 as envoy

# Use Fedora 35 as the base image
FROM registry.fedoraproject.org/fedora:35

# Add HashiCorp Fedora YUM repository
ADD https://rpm.releases.hashicorp.com/fedora/hashicorp.repo /etc/yum.repos.d/

# Install Consul and systemd (required for the init inside container)
RUN dnf install -y consul systemd && \
    dnf clean all

# Enable Consul Service
RUN systemctl enable consul

# Copy Envoy binary from envoy docker image
COPY --from=envoy /usr/local/bin/envoy /usr/local/bin/envoy

# Install HashiCorp counting and dashboard binaries

RUN curl -sL https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/dashboard-service_linux_amd64.zip | zcat  >> /usr/local/bin/dashboard && \
    curl -sL https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/counting-service_linux_amd64.zip | zcat >> /usr/local/bin/counting && \
    chmod +x /usr/local/bin/dashboard && \
    chmod +x /usr/local/bin/counting

# Use systemd as command
CMD ["/usr/sbin/init"]
