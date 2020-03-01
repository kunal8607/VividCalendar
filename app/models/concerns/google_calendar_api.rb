require "google/apis/calendar_v3"
require "google/api_client/client_secrets.rb"

module GoogleCalendarApi

  include ActiveSupport::Concern

  def get_google_calendar_client current_user
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless (current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?)

    secrets = Google::APIClient::ClientSecrets.new({
      "web" => {
        "access_token" => current_user.access_token,
        "refresh_token" => current_user.refresh_token,
        # "client_id" => Rails.application.credentials.google_client_id,
        # "client_secret" => Rails.application.credentials.google_client_secret
        "client_id" => "927961015660-jc1pmk12copb582o2ol12ndp4qk16rqb.apps.googleusercontent.com",
        "client_secret" => "AR5YSAajrRi91iyogA8p2Z9Z"
      }
    })
    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = "refresh_token"

      if current_user.expired?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue => e
      raise e.message
    end
    client
  end


  

  def sync_cals(user)
    
  end

end