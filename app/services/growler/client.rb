# frozen_string_literal: true
require 'ruby-growl'
require 'singleton'

module Growler
  class Client
    include Singleton
    def notify
      g = Growl.new('localhost', 'Daryllxd Growler')
      g.add_notification('haha')
      g.notify('haha', 'hoho', 'Did you write things today?')
      g.notify('haha', 'hoho', 'Did you take photos of your food today?')
    end

    def backed_up_database
      g = Growl.new('localhost', 'Database backup.')
      g.add_notification('DB Backup.')
      g.notify('DB Backup.', 'Daryllxd', 'Backed up database.')
    end
  end
end
