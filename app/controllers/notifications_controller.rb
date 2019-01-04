class NotificationsController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: UI::NotificationListReadModel.new.all, status: :ok }
      format.html { render action: :index, locals: { notifications: UI::NotificationListReadModel.new.all } }
    end
  end
end
