class Calendar < ApplicationRecord
  extend GoogleCalendarApi
  has_many :events
  belongs_to :user

  def self.sync_cal user
  	cals= get_cals user

  	cals.each do |i|
  		calendar= Calendar.find_or_initialize_by(google_id: i[:google_id], user_id: user.id)
  		calendar.assign_attributes(i)
  		calendar.save
  	end

  	client = get_google_calendar_client user
  	user.calendars.each do |i|
  	  events = client.list_events(i.google_id).items
  	  events.each do |e|
  	  	  event = Event.find_or_initialize_by(google_id: e.id, calendar_id: i.id)
		  event.assign_attributes({title: e.summary, description: e.description, start_date: e.start.date_time || e.start.date, end_date: e.end.date_time || e.end.date})
		  event.save
	  end
  	end
  end
end
