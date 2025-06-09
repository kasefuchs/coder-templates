packer {
  required_plugins {
    yandex = {
      source  = "github.com/hashicorp/yandex"
      version = ">= 1.1.3"
    }

    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.3"
    }
  }
}
