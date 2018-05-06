# frozen_string_literal: true

module GoogleBooks
  class Client
    attr_reader :title

    def initialize(title)
      @title = title
    end

    def search
      actual_title = title.parameterize
      Faraday.get("https://www.googleapis.com/books/v1/volumes?q=#{actual_title}")
    end
  end
end
