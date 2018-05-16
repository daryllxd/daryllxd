# frozen_string_literal: true

module Api
  module V1
    RSpec.describe ActivityTagsController, type: :controller do
      context 'logged in' do
        it 'grabs all the Pomodoros in a day' do
          create(:activity_tag, :programming)

          get :index

          expect(response).to be_success
          expect(json_response['data']).to have_key('activity_tags')
          expect(json_response['data']['activity_tags']).to be_present
        end
      end

      context 'unauthorized' do
        xit 'pending until I integrate doorkeeper' do
          get :index

          expect(response.status).to eq(401)
        end
      end
    end
  end
end
