source "yandex" "workspace" {
  use_ipv4_nat = true

  zone                = var.yandex.zone
  preemptible         = var.yandex.preemptible
  disk_size_gb        = var.yandex.disk_size
  ssh_username        = var.yandex.ssh_username
  image_family        = var.yandex.result_image_family
  source_image_family = var.yandex.source_image_family
}

source "docker" "workspace" {
  commit = true

  build {
    path      = var.docker.source_image_build.path
    arguments = var.docker.source_image_build.arguments
  }
}
