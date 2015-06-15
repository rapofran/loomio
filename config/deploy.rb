set :application, 'loomio'
set :repo_url, 'https://github.com/piratas-ar/loomio'
set :linked_files, %w{.env}
set :linked_dirs, %w{public/system}

set :rbenv_type, :user
set :rbenv_ruby, '2.2.1'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

namespace :deploy do
  desc "Reiniciar delayed jobs"
  task :restart do
    invoke 'delayed_job:restart'
  end
end
after 'deploy:publishing', 'deploy:restart'
