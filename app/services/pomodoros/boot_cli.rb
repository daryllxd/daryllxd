# frozen_string_literal: true
# Loads everything needed for the Pomodoro sub-app

require './app/models/application_record'
require './app/models/pomodoro'
require './app/services/pomodoros/create_service'
require './app/services/pomodoros/presenters/for_today'

db_config = YAML.safe_load(File.open('./config/database.yml'))['development']
ActiveRecord::Base.establish_connection(db_config)
