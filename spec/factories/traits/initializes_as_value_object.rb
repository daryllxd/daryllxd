# frozen_string_literal: true
# Thiw will allow the creation of a PORO from a hash of constructor objects
# Think
#
# alice = create(:user, first_name: 'Alice')
#
# where User is a
#
# class User
#   def initialize(first_name:)
#     @first_name = first_name
#   end
# end
#

FactoryGirl.define do
  trait :initializes_as_value_object do
    skip_create
    initialize_with do
      if attributes.present?
        new(attributes)
      else
        new
      end
    end
  end
end
