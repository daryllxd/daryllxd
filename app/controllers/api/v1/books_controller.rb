# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApiController
      def index
        books = Book.all

        render json: { books: books }
      end

      def search
        search_results = GoogleBooks::BookSearcher.call(
          title: params[:title]
        )

        if search_results.valid?
          render json: search_results.payload
        else
          render_error_from(search_results)
        end
      end
    end
  end
end
