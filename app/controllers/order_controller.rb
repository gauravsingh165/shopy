class OrderController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :update]
  skip_before_action :verify_authenticity_token


  def show
  end

  def update
    if @order.update(order_params)
      flash[:success] = 'Order item was successfully updated.'
      redirect_to checkout_create_path
    else
      flash.now[:error] = 'Failed to update order item.'
      render :show
    end 
  end

  private

  def set_order
    @order = Order.find_by(id: params[:order_id])
  end

  def order_params
    params.require(:order).permit(:user_id, :product_id, :name, :email, :address, :phone,:status)
  end
end
