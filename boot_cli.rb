# frozen_string_literal: true
class BootCli
  attr_reader :presumed_symlink

  def initialize(presumed_symlink:)
    @presumed_symlink = presumed_symlink
  end

  def boot
    require 'rb-readline'
    require 'pry-byebug'
    require 'thor'
    require 'memoist'
    require 'active_record'
    require 'app/models/application_record'
    # Ensure all references to timezones are in the EST (my day usually starts at that time anyway).
    Time.zone = 'America/New_York'

    # Connect to database, and add as symlink
    db_base_dir = if File.exist?(presumed_symlink) && File.symlink?(presumed_symlink)
                    File.readlink(presumed_symlink).split('/')[0..-3].join(File::SEPARATOR)
                  else
                    './'
                  end

    db_config_file = File.join(db_base_dir, 'config/database.yml')

    db_config = YAML.safe_load(File.open(db_config_file))['development']
    ActiveRecord::Base.establish_connection(db_config)
  end
end
