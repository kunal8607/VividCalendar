# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.string :google_id
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :members
      t.timestamps
    end
  end
end
