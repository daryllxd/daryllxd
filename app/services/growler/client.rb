# frozen_string_literal: true
module Growler
  class Client
    def notify
      g = Growl.new('localhost', 'Daryllxd Growler')
      g.add_notification('haha')
      g.notify('haha', 'hoho', 'yolo')
    end
  end
end
