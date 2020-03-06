class Event < ApplicationRecord
	extend GoogleCalendarApi
	belongs_to :calendar

	def self.get_client user
		get_google_calendar_client user
	end
end