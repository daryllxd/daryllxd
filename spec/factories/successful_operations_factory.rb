# frozen_string_literal: true
FactoryGirl.define do
  factory :successful_operation, class: SuccessfulOperation do
    initializes_as_value_object
  end
end
