# frozen_string_literal: true

RSpec.describe Users::CreateService, type: :service do
  context 'happy path' do
    it 'creates a user object' do
      new_user_attributes = { email: 'hello@yahoo.com', password: 'hello@yahoo.com' }

      new_user = execute.call(new_user_attributes)

      expect(new_user).to be_valid
      expect(new_user.payload).to be_a_kind_of(User)
      expect(new_user.payload.email).to eq('hello@yahoo.com')
    end
  end

  context 'errors' do
    context 'email is already taken' do
      it 'do not save user' do
        new_user_attributes = { email: 'hello@yahoo.com', password: 'hello@yahoo.com' }
        create(:user, email: new_user_attributes[:email])

        new_user = execute.call(new_user_attributes)

        expect(new_user).not_to be_valid
        expect(new_user.message).to eq 'Email has already been taken'
        expect(new_user.payload).to be_a_kind_of(User)
        expect(new_user.payload).not_to be_persisted
      end
    end

    context 'invalid email address' do
      it 'do not save user' do
        new_user_attributes = { email: '', password: '' }

        new_user = execute.call(new_user_attributes)

        expect(new_user).not_to be_valid
        expect(new_user.message).to eq "Email can't be blank, Password can't be blank"
        expect(new_user.payload).to be_a_kind_of(User)
        expect(new_user.payload).not_to be_persisted
      end
    end
  end
end
