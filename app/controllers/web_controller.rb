# frozen_string_literal: true

class WebController < ActionController::Base
  protect_from_forgery with: :exception
end
