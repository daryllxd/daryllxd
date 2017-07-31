# frozen_string_literal: true
# Loads everything needed for the Pomodoro sub-app
require 'rb-readline'
require 'pry-byebug'
require 'app/models/application_record'
require 'app/models/pomodoro'
require 'app/models/pomodoro_activity_tag'
require 'app/models/activity_tag'
require 'app/services/pomodoros/tag_resolver'
require 'app/services/pomodoros/create_service'
require 'app/services/pomodoros/append_service'
require 'app/errors/daryllxd_error'
require 'app/services/pomodoros/errors/generic_error'
require 'app/services/pomodoros/presenters/for_today'

presumed_symlink = '/usr/local/bin/p'

db_base_dir = if File.exist?(presumed_symlink) && File.symlink?(presumed_symlink)
                File.readlink(presumed_symlink).split('/')[0..-3].join(File::SEPARATOR)
              else
                './'
              end

db_config_file = File.join(db_base_dir, 'config/database.yml')

db_config = YAML.safe_load(File.open(db_config_file))['development']
ActiveRecord::Base.establish_connection(db_config)
