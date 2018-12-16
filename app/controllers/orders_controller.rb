class OrdersController < ApplicationController
  def index
    respond_to do |format|
      format.json { render json: UI::OrderListReadModel.new.all, status: :ok }
      format.html { render action: :index, locals: { orders: UI::OrderListReadModel.new.all } }
    end
  end
end
