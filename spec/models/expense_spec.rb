# frozen_string_literal: true
RSpec.describe Expense, type: :model do
  context 'validations' do
    it  { should validate_presence_of(:description) }

    it  { should validate_presence_of(:amount) }
    it  { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end
end
