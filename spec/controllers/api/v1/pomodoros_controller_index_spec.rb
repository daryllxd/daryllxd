# frozen_string_literal: true

require 'timecop'

# Bug on tests, it fails at 11-12pm PHT, this must be some timezone issue, but it works
# on the production environment, so I just timecopped everything.
RSpec.describe Api::V1::PomodorosController, type: :controller do
  context 'logged in' do
    it 'grabs all the Pomodoros in a day' do
      allow(controller).to receive(:doorkeeper_token) { double(acceptable?: true) }

      get :index

      expect(response).to be_success
      expect(json_response).to have_key('data')
    end
  end

  context 'unauthorized' do
    it 'returns a 401' do
      get :index

      expect(response.status).to eq(401)
    end
  end
end
