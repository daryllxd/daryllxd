# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApiController
      def create
        new_user = Users::CreateService.call(
          permitted_params.to_h.symbolize_keys
        )

        if new_user.valid?
          render_token_with(
            user: new_user, payload: { user: new_user }
          )
        else
          render_error_from(new_user)
        end
      end

      private

      def permitted_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
