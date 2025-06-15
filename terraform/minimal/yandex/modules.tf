module "coder-login" {
  count    = data.coder_workspace.main.start_count
  agent_id = coder_agent.main.id

  source  = "registry.coder.com/coder/coder-login/coder"
  version = "1.0.15"
}

module "personalize" {
  count    = data.coder_workspace.main.start_count
  agent_id = coder_agent.main.id

  source  = "registry.coder.com/coder/personalize/coder"
  version = "1.0.2"
}
