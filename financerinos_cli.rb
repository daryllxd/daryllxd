# frozen_string_literal: true
require 'boot_cli'
BootCli.new(presumed_symlink: '/usr/local/bin/exp').boot

require 'app/services/financerinos/boot_cli'

class FinancerinosCli < Thor
  desc 'new', 'Makes a new expense'
  method_option :description, type: :string, aliases: '-d'
  method_option :amount, type: :numeric, aliases: '-a'
  method_option :tags, type: :string, aliases: '-t'

  def new
    resolved_tags = Financerinos::Expenses::TagResolver.new(
      tag_string: options[:tags]
    ).call

    Financerinos::Expenses::CreateService.new(
      description: options[:description],
      amount: options[:amount],
      tags: resolved_tags
    ).call

    puts 'Expense logged!'
  end

  desc 'list', 'Show all expenses'

  def list
    Expense.all.each do |ex|
      puts "#{ex.description}, #{ex.amount}"
    end
  end
end
