class OrderItemsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index

   @order_items=OrderItem.all 
  end


  def create
    @order = current_order
    @order.user = current_user
    @order_item = @order.order_items.new(order_params)
    if @order.save 
      session[:order_id]=@order.id
      redirect_to root_path
    end
  end
  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    
    if @order_item.update(order_params)
      flash[:success] = 'Order item was successfully updated.'
      @order_items = current_order.order_items 
      redirect_to card_path(id: 1) # Use order_items instead of order_item
    else
      flash.now[:error] = 'Failed to update order item.'
      render :edit
    end 
  end
  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to card_path(id: 1), notice: 'Order item was successfully removed.' }
      format.js
    end
  end
  
  private

  def order_params
    params.require(:order_item).permit(:product_id,:quantity)
  end
end
