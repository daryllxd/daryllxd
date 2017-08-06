# frozen_string_literal: true
# Loads everything needed for the Financerinos sub-app
require 'rb-readline'
require 'pry-byebug'
require 'app/models/application_record'
require 'app/models/date_range_factory'
require 'app/models/date_range'
require 'app/models/expense'
require 'app/errors/daryllxd_error'
require 'app/services/financerinos/expenses/create_service'
require 'app/services/pomodoros/presenters/for_today'

presumed_symlink = '/usr/local/bin/exp'

db_base_dir = if File.exist?(presumed_symlink) && File.symlink?(presumed_symlink)
                File.readlink(presumed_symlink).split('/')[0..-3].join(File::SEPARATOR)
              else
                './'
              end

db_config_file = File.join(db_base_dir, 'config/database.yml')

db_config = YAML.safe_load(File.open(db_config_file))['development']
ActiveRecord::Base.establish_connection(db_config)
