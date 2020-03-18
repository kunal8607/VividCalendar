# frozen_string_literal: true

class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :bg_color
      t.string :google_id
      t.references :user
      t.timestamps
    end
  end
end
