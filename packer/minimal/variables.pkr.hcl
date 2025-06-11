variable "yandex" {
  type = object({
    zone                = string
    preemptible         = bool
    disk_size           = number
    ssh_username        = string
    source_image_family = string
    result_image_family = string
  })

  default = {
    zone                = "ru-central1-d"
    preemptible         = true
    disk_size           = 5
    ssh_username        = "debian"
    source_image_family = "debian-12"
    result_image_family = "coder-base-debian-12"
  }
}

variable "docker" {
  type = object({
    source_image_build = object({
      path      = string
      arguments = map(string)
    })
    result_image_tags       = list(string)
    result_image_repository = string
  })

  default = {
    source_image_build = {
      path      = "../../docker/Dockerfile.archlinux"
      arguments = { "DISTRO_TAG" : "base" }
    }
    result_image_tags       = ["base"]
    result_image_repository = "ghcr.io/kasefuchs/coder-workspace-archlinux-minimal"
  }
}

variable "docker_login" {
  type = object({
    server   = string
    username = string
    password = string
  })

  default   = null
  sensitive = true
}
