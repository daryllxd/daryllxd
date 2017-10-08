# frozen_string_literal: true
namespace :growler do
  desc "TODO"
  task notify: :environment do
    Growler::Client.instance.notify
  end
end
