module Users
  module Contacts
    class InviteService
      attr_reader :inviter, :contact

      def initialize(inviter:, contact:)
        @inviter = inviter
        @contact = contact
      end

      # Raise error if fail
      # Create a User object for non-registered emails, skip validations since they have to set passwords and usernames
      def call
        unless contact.daryllxd_member?
          new_contact = User.create!(user_create_attributes)
        end

        inviter.sent_contact_relationships.create!(receiver_user: new_contact ? new_contact : contact)

        if new_contact
          new_contact
        else
          contact
        end
      end

      private

      def user_create_attributes
        {
          email: contact.email,
          first_name: contact.first_name,
          handicap_value: contact.handicap_value,
          last_name: contact.last_name,
          phone_number: contact.phone_number,
          confirmation_token: generate_confirmation_token,
          invited_by_user: inviter
        }
      end

      def generate_confirmation_token
        SecureRandom.hex(32)
      end
    end
  end
end
