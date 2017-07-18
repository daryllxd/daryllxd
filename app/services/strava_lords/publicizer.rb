# frozen_string_literal: true
require 'rb-readline'
require 'pry'
require 'watir'
require 'dotenv'
Dotenv.load

module StravaLords
  class Publicizer
    # rubocop:disable MethodLength, AbcSize
    def call
      browser = Watir::Browser.new(:chrome)
      browser.goto 'strava.com/login'

      # Go to fb Login screen
      fb_login_button = browser.as(class: 'button fb-button')
      fb_login_button.first.click

      # Log in to facebook
      fb_email_field = browser.inputs(placeholder: 'Email or Phone Number').first
      fb_password_field = browser.inputs(placeholder: 'Password').first
      fb_login_button = browser.buttons(name: 'login').first

      fb_email_field.send_keys(ENV['DARYLLS_FACEBOOK_LOGIN_EMAIL'])
      fb_password_field.send_keys(ENV['DARYLLS_FACEBOOK_LOGIN_PASSWORD'])

      fb_login_button.click

      # Visit Strava activities
      browser.goto 'strava.com/athlete/training'

      browser.table(:id, 'search-results').wait_until_present

      private_activity_training_rows = browser.trs(class: 'training-activity-row').select do |x|
        x.divs(title: 'Private').first.visible?
      end

      private_activity_training_rows.each do |tr|
        edit_button = tr.buttons(class: 'btn btn-link btn-xs quick-edit').first
        edit_button.click

        # Unprivatize
        tr.checkboxes(name: 'private').first.set(false)
        tr.buttons(type: 'submit').first.click
      end

      browser.close
    rescue Watir::Exception => e
      puts e
    end
    # rubocop:enable MethodLength, AbcSize
  end
end
