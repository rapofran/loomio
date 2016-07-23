set :application, 'loomio'
set :repo_url, 'https://github.com/piratas-ar/loomio'
set :linked_files, %w{.env}
set :linked_dirs, %w{public/system log tmp/pids}

set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

namespace :deploy do
  desc 'Reiniciar delayed jobs'
  task :restart do
    invoke 'delayed_job:restart'
  end
end

namespace :loomio do
  desc 'Correr tareas de loomio'
  task :deploy do
    on roles(:web) do
      within release_path do
        execute :rake, 'deploy:build'
      end
    end
  end

end

namespace :faye do
  desc 'Iniciar faye'
  task :start do
    on roles(:web) do
      within release_path do
        execute :bundle, 'exec rackup --pid tmp/pids/faye.pid --daemonize private_pub.ru'
      end
    end
  end

  desc 'Detener faye'
  task :stop do
    on roles(:web) do
      within release_path do
        execute :pkill, '--signal INT --pidfile tmp/pids/faye.pid'
      end
    end
  end

  desc 'Reiniciar faye'
  task :restart do
    invoke 'faye:stop'
    invoke 'faye:start'
  end
end

after 'deploy:publishing', 'loomio:deploy'
after 'deploy:publishing', 'deploy:restart'
after 'deploy:publishing', 'faye:restart'
