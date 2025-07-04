terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }

    coder = {
      source = "coder/coder"
    }

    cloudinit = {
      source = "hashicorp/cloudinit"
    }
  }
}
