packer {
  required_plugins {
    qemu = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}


variable "consul_version" {
  type        = string
  default     = "1.18"
  description = "Consul version to install"
}

variable "nomad_version" {
  type        = string
  default     = "1.7"
  description = "Nomad version to install"
}

source "qemu" "hashibox" {
  iso_url          = "https://download.fedoraproject.org/pub/fedora/linux/releases/40/Cloud/aarch64/images/Fedora-Cloud-Base-Generic.aarch64-40-1.14.qcow2"
  iso_checksum     = "sha256:ebdce26d861a9d15072affe1919ed753ec7015bd97b3a7d0d0df6a10834f7459"
  headless         = true
  disk_compression = true
  disk_size        = "10G"
  disk_interface   = "virtio"
  format           = "qcow2"
  disk_image       = true
  boot_command     = []
  net_device       = "virtio-net"

  output_directory = "artifacts/qemu/c-${var.consul_version}-n-${var.nomad_version}"

  qemu_binary      = "qemu-system-aarch64"
  accelerator      = "hvf"
  cpu_model        = "cortex-a57"
  machine_type     = "virt"
  cpus             = 2
  memory           = 2048
  use_backing_file = true

  efi_boot          = true
  efi_firmware_code = "/opt/homebrew/share/qemu/edk2-aarch64-code.fd"
  efi_firmware_vars = "/opt/homebrew/share/qemu/edk2-arm-vars.fd"

  qemuargs = [
    ["-cdrom", "userdata/cidata.iso"],
    ["-monitor", "none"],
    ["-no-user-config"]
  ]

  communicator     = "ssh"
  shutdown_command = "echo fedora | sudo -S shutdown -P now"
  ssh_password     = "fedora"
  ssh_username     = "fedora"
  ssh_timeout      = "20m"
}


build {
  sources = ["source.qemu.hashibox"]

  provisioner "shell" {
    inline = [
      "sudo dnf clean all",
      "sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo",
      "sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",

      "sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo",
      "sudo dnf install -y consul nomad containernetworking-plugins",

      "sudo systemctl enable docker consul nomad"
    ]

  }

  post-processor "checksum" {
    checksum_types = ["sha256"]
    output         = "hashibox_c-${var.consul_version}-n-${var.nomad_version}-{{.ChecksumType}}.CHECKSUM"
  }
}