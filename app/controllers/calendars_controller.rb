class CalendarsController < ApplicationController
  def index
  	if current_user.calendars.empty? || params[:sync] == 'true'
  	 calenders= Calendar.sync_cal current_user
  	 @cals = current_user.calendars
  	else
  	 @cals = current_user.calendars	
    end
  end

  def show
  	@calendar = Calendar.find(params[:id])
  	if params[:older] == 'true'
  		@events = @calendar.events.where("start_date <= ?", Date.today).order(start_date: :desc)
  	else
  		@events = @calendar.events.where("start_date >= ?", Date.today).order(:start_date)
  	end
  end
end
