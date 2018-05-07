# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApiController
      # before_action :doorkeeper_authorize!

      def index
        books = Book.all

        render json: { books: books }
      end
    end
  end
end
