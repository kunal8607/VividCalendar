class CalendarsController < ApplicationController
  def index
  	calenders= Calendar.sync_cal current_user
  	@cals = current_user.calendars
  end

  def show
  end
end
