# frozen_string_literal: true
RSpec.describe GraphqlsController, type: :controller do
  it 'initial test for GraphQL works' do
    pomodoro = create(:pomodoro, description: 'haha', duration: 2)
    expense = create(:expense, description: 'choho', amount: 2)

    post :create, params: {
      query: "
      {
        pomodoro(id: #{pomodoro.id}) { description }
        expense(id: #{expense.id}) { amount, description }
      }
      "
    }

    expect(json_response['data'].keys).to eq(%w(pomodoro expense))
  end
end
