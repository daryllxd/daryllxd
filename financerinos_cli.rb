# frozen_string_literal: true
require 'thor'
require 'active_record'
require 'app/services/financerinos/boot_cli'

# Ensure all references to timezones are in UTC.
ENV['TZ'] = 'UTC'
Time.zone = 'UTC'

class FinancerinosCli < Thor
  desc 'new', 'Makes a new expense'
  method_option :description, type: :string, aliases: '-d'
  method_option :amount, type: :numeric, aliases: '-a'

  def new
    Financerinos::Expenses::CreateService.new(
      description: options[:description],
      amount: options[:amount]
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
