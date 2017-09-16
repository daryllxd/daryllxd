# frozen_string_literal: true

RSpec.describe ExpenseBudgetTag, type: :model do
  context 'validations' do
    it { should validate_presence_of(:expense) }
    it { should validate_presence_of(:budget_tag) }
  end

  context 'associations' do
    it { should belong_to(:expense) }
    it { should belong_to(:budget_tag) }
  end
end
