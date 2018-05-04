# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id                      :integer          not null, primary key
#  title                   :string           not null
#  subtitle                :string
#  amazon_url              :string
#  authors                 :string           default([]), is an Array
#  description             :string
#  google_books_url        :string
#  thumbnail_url           :string
#  google_books_api_data   :jsonb
#  google_books_scraped_at :date
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Book < ApplicationRecord
  validates :title, presence: true
end
