# frozen_string_literal: true

require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

module GoogleCalendarApi
  include ActiveSupport::Concern

  def get_google_calendar_client(current_user)
    client = Google::Apis::CalendarV3::CalendarService.new
    unless current_user.present? &&
           current_user.access_token.present? &&
           current_user.refresh_token.present?
      return
    end

    secrets = Google::APIClient::ClientSecrets.new({
                                                     'web' => {
                                                       'access_token' => current_user
                                                       .access_token,
                                                       'refresh_token' => current_user
                                                       .refresh_token,
                                                       'client_id' => Rails.application.credentials
                                                       .google[:client_id],
                                                       'client_secret' => Rails.application
                                                       .credentials
                                                       .google[:client_secret]
                                                     }
                                                   })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = 'refresh_token'

      if current_user.expired?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue StandardError => e
      raise e.message
    end
    client
  end

  def sync_events(user)
    client = get_google_calendar_client(user)
    calendars = client.list_calendar_lists.items
  end

  def get_cals(user)
    client = get_google_calendar_client(user)
    calendars = client.list_calendar_lists.items.map do |i|
      { name: i.summary, bg_color: i.background_color, google_id: i.id }
    end
  end
end
