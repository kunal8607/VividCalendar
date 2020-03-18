# frozen_string_literal: true

class HomeController < ApplicationController
  def index; end

  def bad_name
    test if something
  end
end
