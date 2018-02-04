# frozen_string_literal: true
RSpec.describe Expense, type: :model do
  context 'validations' do
    it  { should validate_presence_of(:description) }

    it  { should validate_presence_of(:amount) }
    it  { should validate_presence_of(:spent_on) }
    it  { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end

  context 'associations' do
    it { should have_many(:expense_budget_tags) }
    it { should have_many(:budget_tags).through(:expense_budget_tags) }
  end
end
