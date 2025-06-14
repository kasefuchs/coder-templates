locals {
  cloud_init_user_data = templatefile("${path.module}/user-data.tftpl", {
    coder_agent_url   = data.coder_workspace.main.access_url
    coder_agent_token = coder_agent.main.token
  })
}
