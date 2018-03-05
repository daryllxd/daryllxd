# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def to_error_message_string
    errors.full_messages.join(', ')
  end
end
