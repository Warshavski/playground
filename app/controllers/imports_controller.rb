class ImportsController < ApplicationController
  before_action :doorkeeper_authorize!

  def upload
    authorize! :import, to: :upload?
    head :ok
  end

  def create
    authorize! :import, to: :create?
    head :ok
  end
end
