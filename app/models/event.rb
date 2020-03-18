# frozen_string_literal: true

class Event < ApplicationRecord
  validates :title, presence: true
  validates :google_id, presence: true
end
