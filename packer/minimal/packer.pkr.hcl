packer {
  required_plugins {
    yandex = {
      source  = "github.com/hashicorp/yandex"
      version = ">= 1.1.3"
    }

    docker = {
      source  = "github.com/hashicorp/docker"
      version = ">= 1.1.1"
    }

    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.3"
    }
  }
}
