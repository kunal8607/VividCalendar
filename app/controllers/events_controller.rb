class EventsController < ApplicationController
  def index
  	@event = Event.first.sync_events(current_user)

  	render json: @event
  end
end
