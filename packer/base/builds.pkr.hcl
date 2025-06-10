build {
  sources = ["source.yandex.workspace", "source.docker.workspace"]

  provisioner "ansible" {
    playbook_file    = "${local.ansible_directory}/playbooks/base.yml"
    ansible_env_vars = ["ANSIBLE_CONFIG=${local.ansible_directory}/ansible.cfg"]
  }

  post-processors {
    post-processor "docker-tag" {
      only = ["docker.workspace"]

      tags       = var.docker.result_image_tags
      repository = var.docker.result_image_repository
    }

    post-processor "docker-push" {
      only = ["docker.workspace"]
    }
  }
}
