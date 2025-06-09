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
