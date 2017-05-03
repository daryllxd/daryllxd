module Users
  module Contacts
    class CreateService < BaseService
      attr_reader :inviter, :contacts

      def initialize(inviter:, contacts:)
        @inviter = inviter
        @contacts = contacts
      end

      def perform
        invited_contacts = Users::Contacts::ContactRelationshipRequestResult.new

        ActiveRecord::Base.transaction do
          contacts.each do |contact|
            new_contact = invite_contact(contact)
            invited_contacts.add_contact(new_contact)
          end
        end

        invited_contacts
      end

      def invite_contact(contact)
        Users::Contacts::InviteService.new(
          inviter: inviter,
          contact: contact
        ).call
      end
    end
  end
end
