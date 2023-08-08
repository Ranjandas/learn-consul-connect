# Use Fedora 35 as the base image
FROM registry.fedoraproject.org/fedora:38

# Add HashiCorp Fedora YUM repository
ADD https://rpm.releases.hashicorp.com/fedora/hashicorp.repo /etc/yum.repos.d/

# Use fastest mirror available
RUN echo "fastestmirror=True" >> /etc/dnf/dnf.conf

# Install Consul and systemd (required for the init inside container)
RUN dnf install -y consul \
       nomad \
		   systemd \
		   tcpdump \
		   iproute \
		   bind-utils \
		   less \
		   jq \
		   procps-ng \
		   iptables \
       iputils && \
    dnf clean all


# Install CNI Plugins
RUN curl  -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v1.0.0/cni-plugins-linux-$( [ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)"-v1.0.0.tgz && \
    mkdir -p /opt/cni/bin && \
    tar -C /opt/cni/bin -xzf cni-plugins.tgz


# Enable Consul and Nomad
RUN systemctl enable consul \
      nomad 


# Use systemd as command
CMD ["/usr/sbin/init"]
