# frozen_string_literal: true
namespace :db do
  desc 'Backs up the database'
  task backup: :environment do
    system("pg_dump daryllxd_development > db/backups/daryllxd_development-#{DateTime.current}.sql")
  end
end
