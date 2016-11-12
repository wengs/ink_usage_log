set :stage, :staging
set :deploy_to, "/home/ink_usage_waste_app/#{fetch(:application)}"
set :rails_env, 'staging'

server '104.236.62.152', user: 'ink_usage_waste_app', roles: %w(db web app)

set :ssh_options,
  user: 'ink_usage_waste_app',
  keys_only: true,
  paranoid: false, # ignore host key mismatch (result of spinning a new vm)
  forward_agent: true, # to git fetch, if we switch to the remote url
  auth_methods: ['publickey'],
  port: 22,
  config: true