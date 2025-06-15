data "coder_workspace" "main" {}

data "coder_workspace_owner" "main" {}

data "coder_parameter" "platform_id" {
  icon         = "/emojis/1f689.png"
  name         = "platform_id"
  display_name = "Platform"
  description  = "Specifies platform for the instance."

  type    = "string"
  default = "standard-v3"
  mutable = true

  option {
    icon  = "/emojis/1f4a6.png"
    name  = "Intel Cascade Lake"
    value = "standard-v2"
  }

  option {
    icon  = "/emojis/1f9ca.png"
    name  = "Intel Ice Lake"
    value = "standard-v3"
  }
}

data "coder_parameter" "cores" {
  icon         = "/emojis/1f525.png"
  name         = "cores"
  display_name = "Number of cores"
  description  = "Specifies how many CPU cores workspace should have."

  type    = "number"
  default = 2
  mutable = true

  validation {
    min = 2
  }
}

data "coder_parameter" "memory" {
  icon         = "/emojis/1f9e0.png"
  name         = "memory"
  display_name = "Amount of memory"
  description  = "Specifies how much memory workspace should have."

  type    = "number"
  default = 1
  mutable = true

  validation {
    min = 1
  }
}

data "coder_parameter" "core_fraction" {
  icon         = "/emojis/1f680.png"
  name         = "core_fraction"
  display_name = "Core fraction"
  description  = "Specifies baseline performance for a core in percent."

  type    = "number"
  default = 20
  mutable = true

  option {
    icon  = "/emojis/1f422.png"
    name  = "20%"
    value = 20
  }

  option {
    icon  = "/emojis/1f408.png"
    name  = "50%"
    value = 50
  }

  option {
    icon  = "/emojis/1f406.png"
    name  = "100%"
    value = 100
  }
}

data "coder_parameter" "disk_type" {
  icon         = "/emojis/1f4bd.png"
  name         = "disk_type"
  display_name = "Disk type"
  description  = "Specifies the type of the disk."

  type    = "string"
  default = "network-hdd"
  mutable = false

  option {
    icon  = "/emojis/1f422.png"
    name  = "HDD"
    value = "network-hdd"
  }

  option {
    icon  = "/emojis/1f408.png"
    name  = "SSD"
    value = "network-ssd"
  }
}

data "coder_parameter" "disk_size" {
  icon         = "/emojis/1f4be.png"
  name         = "disk_size"
  display_name = "Disk size"
  description  = "Specifies the size of the boot disk in GB."

  type    = "number"
  default = 5
  mutable = true

  validation {
    min = 5
  }
}

data "coder_parameter" "preemptible" {
  icon         = "/emojis/1f47b.png"
  name         = "preemptible"
  display_name = "Preemptible"
  description  = "Launch a preemptible instance."

  type    = "bool"
  default = true
  mutable = true
}

data "cloudinit_config" "main" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "cloud-config.yml"
    content_type = "text/cloud-config"

    content = templatefile("${path.module}/cloud-init/cloud-config.yml.tftpl", {
      coder_agent_url   = data.coder_workspace.main.access_url
      coder_agent_token = coder_agent.main.token
    })
  }
}

data "yandex_client_config" "main" {}

data "yandex_resourcemanager_folder" "main" {
  folder_id = data.yandex_client_config.main.folder_id
}

data "yandex_compute_image" "source" {
  family    = var.yandex_image_family
  folder_id = data.yandex_resourcemanager_folder.main.id
}

data "yandex_vpc_subnet" "main" {
  subnet_id = var.yandex_subnet_id
}
