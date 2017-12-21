set :stage, :production
set :unicorn_rack_env, 'production'
set :branch, :master

# Sbidu Generators - You might want to change the application name
set :deploy_to, '/u01/apps/rs/demo-site.com'
set :log_level, :debug

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.

# Sbidu Generators - To Be Changed
role :app, %w{deployer@34.250.212.49}
role :web, %w{deployer@34.250.212.49}
role :db, %w{deployer@34.250.212.49}
server '34.250.212.49', roles: %w{:web, :app, :db}, user: 'deployer'

set :ssh_options, {
   #verbose: :debug,
   keys: %w(~/.ssh/id_rsa),
   auth_methods: %w(publickey)
}
