# frozen_string_literal: true

namespace :my_calendar do
  desc 'This Task will syce the calendar of all active users'
  task sync: :environment do
    users = User.where('last_sign_in_at > ?', Date.today - 15.days)
    users.each do |i|
      Calendar.sync_cal i
    end
  end
end
