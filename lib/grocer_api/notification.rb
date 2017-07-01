# frozen_string_literal: true
module GrocerApi
  class Notification
    attr_reader :device_token, :client

    def initialize(device_token:, **_optional_attributes)
      @device_token = device_token
      @client = GrocerApi::Client.new
    end

    def notify(alert:)
      client.push(notification_from(alert: alert))
    end

    private

    def notification_from(attrs)
      Grocer::Notification.new({
        alert: attrs[:alert]
      }.merge(attributes_shared_amongst_notifications))
    end

    def attributes_shared_amongst_notifications
      {
        device_token: device_token
      }
    end
  end
end
