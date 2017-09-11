# frozen_string_literal: true
RSpec.describe GraphqlsController, type: :controller do
  it 'initial test for GraphQL works' do
    create(:pomodoro, description: 'haha', duration: 2)
    create(:expense, description: 'choho', amount: 2)

    post :create, params: {
      query: '
      {
        pomodoro(id: 1) { description }
        expense(id: 1) { amount, description }
      }
      '
    }

    expect(json_response['data'].keys).to eq(%w(pomodoro expense))
  end
end
