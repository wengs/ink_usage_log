set :stage, :production
set :deploy_to, "/home/ink_usage_waste_app/#{fetch(:application)}"
set :rails_env, 'production'

# Please change the server IP Address if the EC 2 instance restarts
server '52.33.143.196', user: 'ink_usage_waste_app', roles: %w(db web app)

set :ssh_options,
  user: 'ink_usage_waste_app',
  keys_only: true,
  paranoid: false, # ignore host key mismatch (result of spinning a new vm)
  forward_agent: true, # to git fetch, if we switch to the remote url
  auth_methods: ['publickey'],
  port: 22,
  config: true