# frozen_string_literal: true
RSpec.describe Financerinos::Expenses::CreateService, type: :service do
  context 'happy path' do
    let!(:food_tag) { create(:budget_tag, :food) }
    let!(:uber_tag) { create(:budget_tag, :uber) }

    it 'it works' do
      new_expense_attributes = {
        description: 'Stuff',
        amount: 5,
        tags: [food_tag, uber_tag]
      }

      new_expense = execute.call(new_expense_attributes)

      expect(new_expense).to be_valid
      expect(new_expense).to be_persisted
      expect(new_expense.description).to eq 'Stuff'
      expect(new_expense.amount).to eq 5
      expect(new_expense.budget_tags).to match_array([food_tag, uber_tag])
    end

    context 'custom attributes' do
      it 'custom spent_on date works' do
        new_expense_attributes = {
          description: 'Stuff I did yesterday',
          amount: 4,
          spent_on: Date.current - 1.day
        }

        new_expense = execute.call(new_expense_attributes)

        expect(new_expense).to be_valid
        expect(new_expense).to be_persisted
        expect(new_expense.spent_on).to eq(Date.current - 1.day)
      end
    end
  end

  context 'errors' do
    it 'error in amount--returns an error' do
      new_expense_attributes = {
        description: 'Stuff',
        amount: -5
      }

      new_expense = execute.call(new_expense_attributes)

      expect(Expense.count).to eq 0
      expect(new_expense).not_to be_valid
      expect(new_expense).to be_a_kind_of(DaryllxdError)
    end
  end
end
