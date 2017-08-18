# frozen_string_literal: true
namespace :growler do
  desc "TODO"
  task notify: :environment do
    Growler::Client.new.notify
  end
end
