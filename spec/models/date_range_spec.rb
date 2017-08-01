# frozen_string_literal: true

RSpec.describe DateRange, type: :value do
  it_should_behave_like('value_object_with_setters', 'start_date', 'end_date')
end
