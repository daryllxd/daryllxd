# frozen_string_literal: true
module GrocerApi
  class Client
    delegate :push, to: :client

    attr_reader :client

    def initialize
      @client ||= Grocer.pusher(connection_options)
    end

    def connection_options
      {
        certificate: pem_file_path
      }
    end

    def pem_file_path
      Rails.root.join('spec', 'fixtures', 'sample_pem.cer')
    end
  end
end
