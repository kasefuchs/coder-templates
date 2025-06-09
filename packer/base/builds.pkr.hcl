build {
  sources = ["source.yandex.workspace"]

  provisioner "ansible" {
    playbook_file = "../../ansible/playbooks/base.yml"
  }
}