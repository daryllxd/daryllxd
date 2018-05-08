# frozen_string_literal: true

module GoogleBooks
  class BookSearcher < BaseService
    extend Memoist

    attr_reader :title

    def initialize(title:)
      @title = title
    end

    def call
      if api_response.success?
        if parsed_api_response['totalItems'].positive?
          SuccessfulOperation.new(payload: success_response)
        else
          DaryllxdError.new(message: "No books found for title #{title}.")
        end
      else
        DaryllxdError.new(message: "Something's wrong with the API. Try again later.")
      end
    end

    private

    def parsed_api_response
      JSON.parse(api_response.body)
    end

    def api_response
      GoogleBooks::Client.new(
        title: title
      ).search
    end

    def success_response
      {
        count: parsed_api_response['totalItems'],
        books: parsed_api_response['items']
      }
    end

    memoize :parsed_api_response, :api_response
  end
end
