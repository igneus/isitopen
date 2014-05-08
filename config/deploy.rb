# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'isitopen'
set :repo_url, 'https://github.com/igneus/isitopen.git'
set :branch, 'master'

# set :linked_files, %w{config/database.yml}
set :linked_dirs, [
  'db', # where the sqlite db is stored
  'log',
  'tmp'
]
set :linked_files, %w{config/app.yml config/initializers/secret_token.rb}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

  after :finished, :set_current_version do
    on roles(:app) do
      # dump current git version
      within release_path do
        execute :echo, "#{capture("cd #{repo_path} && git rev-parse --short HEAD")} >> public/REVISION"
      end
    end
  end

end
