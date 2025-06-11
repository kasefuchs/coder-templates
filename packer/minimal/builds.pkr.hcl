build {
  sources = ["source.yandex.workspace", "source.docker.workspace"]

  provisioner "ansible" {
    playbook_file    = "${local.ansible_directory}/playbooks/minimal.yml"
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

      login          = var.docker_login != null
      login_server   = var.docker_login != null ? var.docker_login.server : ""
      login_username = var.docker_login != null ? var.docker_login.username : ""
      login_password = var.docker_login != null ? var.docker_login.password : ""
    }
  }
}
