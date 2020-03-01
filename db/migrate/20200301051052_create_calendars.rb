class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :name
      t.string :bg_color
      t.string :google_id
      t.timestamps
    end
  end
end
