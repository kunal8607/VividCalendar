class Event < ApplicationRecord
	include GoogleCalendarApi
	belongs_to :calendar
end