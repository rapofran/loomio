set :deploy_user, 'app'
set :deploy_to, '/srv/http/consenso.partidopirata.com.ar'
set :branch, 'piratas'

set :rails_env, 'production'

# en Parabola /tmp está montado noexec
set :tmp_dir, "#{fetch :deploy_to}/tmp"

# Las gemas se comparten con otras apps
set :bundle_path, '/srv/http/gemas.partidopirata.com.ar'

# IP del VPS
server 'consenso.partidopirata.com.ar', port: 1863, user: fetch(:deploy_user), roles: %w{app web db}

