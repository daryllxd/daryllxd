# frozen_string_literal: true
RSpec.describe Financerinos::Expenses::CreateService, type: :service do
  context 'happy path' do
    it 'it works' do
      new_expense_attributes = {
        description: 'Stuff',
        amount: 5
      }

      new_expense = execute.call(new_expense_attributes)

      expect(new_expense).to be_valid
      expect(new_expense.description).to eq 'Stuff'
      expect(new_expense.amount).to eq 5
    end
  end

  context 'errors' do
    it 'returns an error' do
      new_expense_attributes = {
        description: 'Stuff',
        amount: -5
      }

      new_expense = execute.call(new_expense_attributes)

      expect(new_expense).not_to be_valid
      expect(new_expense).to be_a_kind_of(DaryllxdError)
    end
  end
end
