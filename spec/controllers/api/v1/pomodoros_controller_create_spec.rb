# frozen_string_literal: true

RSpec.describe Api::V1::PomodorosController, type: :controller do
  context '#create' do
    context 'logged in' do
      context 'happy path' do
        it 'creates a Pomodoro' do
          create_pomodoro_params = { irrelevant: 'irrelevant' }

          allow(Pomodoros::Web::CreateOrganizer).to receive(:call)
            .and_return(double(success: true))
          expect(Pomodoros::Web::CreateOrganizer).to receive(:call)
            .with(create_pomodoro_params)

          post :create, params: create_pomodoro_params

          expect(response).to be_success
          expect(json_response['data']).to have_key('pomodoro')
        end
      end

      context 'error in creation' do
        it 'renders an error' do
          create_pomodoro_params = { irrelevant: 'irrelevant' }

          allow(Pomodoros::Web::CreateOrganizer).to receive(:call)
            .and_return(double(success: false, message: create(:daryllxd_error)))
          expect(Pomodoros::Web::CreateOrganizer).to receive(:call)
            .with(create_pomodoro_params)

          post :create, params: create_pomodoro_params

          expect(response).not_to be_success
          expect(json_response['data']).to have_key('message')
        end
      end
    end

    context 'unauthorized' do
      xit 'returns a 401' do
        # TODO: Until after doorkeeper is fully integrated.
        # For now, comment it out first.
        get :index

        expect(response.status).to eq(401)
      end
    end
  end
end
