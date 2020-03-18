# frozen_string_literal: true

class AddCalendarIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :calendar, foreign_key: true
  end
end
