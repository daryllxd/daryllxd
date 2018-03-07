# frozen_string_literal: true

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  context '#create' do
    context 'happy path' do
      it 'sends a message over to Users::CreateService, and returns a created user' do
        allow(Users::CreateService).to receive(:call).and_return(build_stubbed(:user))
        expect(Users::CreateService).to receive(:call).with(
          email: 'pants@yahoo.com', password: 'pants'
        )

        new_user_params = {
          email: 'pants@yahoo.com',
          password: 'pants'
        }

        post :create, params: { user: new_user_params }

        expect(response.status).to eq 201
        expect(json_response_data['user']).to be_present
        expect(json_response_data['token']).to be_present
      end
    end

    context 'error' do
      it 'sends a message over to Users::CreateService' do
        allow(Users::CreateService).to receive(:call).and_return(
          DaryllxdError.new(
            message: 'There was an error.',
            payload: 'The payload.'
          )
        )

        new_user_params = {
          email: 'pants@yahoo.com',
          password: 'pants'
        }

        post :create, params: { user: new_user_params }

        expect(response.status).to eq 400
        expect(json_response_data['message']).to be_present
        expect(json_response_data['payload']).to be_present
      end
    end
  end
end
