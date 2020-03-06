class EventsController < ApplicationController
  def index
  	# @event = Event.first.sync_events(current_user)
  	calenders= Calendar.sync_cal current_user
  	@cals = current_user.calendars
  	# render json: current_user.calendars
  end
end
