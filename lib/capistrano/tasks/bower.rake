# frozen_string_literal: true
namespace :deploy do
  desc "Install bower"
  task :install_bower do
    on roles(:all) do
      execute "cd #{release_path}/client && bower install --force"
    end
  end

  before "deploy:compile_assets", "install_bower"
end
