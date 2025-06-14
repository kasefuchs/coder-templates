resource "coder_agent" "main" {
  os   = "linux"
  arch = "amd64"
}

resource "yandex_compute_disk" "main" {
  type     = data.coder_parameter.disk_type.value
  size     = data.coder_parameter.disk_size.value
  image_id = data.yandex_compute_image.source.id
}

resource "yandex_compute_instance" "main" {
  count       = data.coder_workspace.main.start_count
  hostname    = lower(data.coder_workspace.main.name)
  metadata    = { user-data = local.cloud_init_user_data }
  platform_id = data.coder_parameter.platform_id.value

  allow_recreate            = true
  allow_stopping_for_update = true

  boot_disk {
    disk_id     = yandex_compute_disk.main.id
    auto_delete = false
  }

  resources {
    cores         = data.coder_parameter.cores.value
    memory        = data.coder_parameter.memory.value
    core_fraction = data.coder_parameter.core_fraction.value
  }

  network_interface {
    nat       = true
    subnet_id = data.yandex_vpc_subnet.main.id
  }

  scheduling_policy {
    preemptible = data.coder_parameter.preemptible.value
  }
}
