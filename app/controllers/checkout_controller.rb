class CheckoutController < ApplicationController
  require 'stripe'
  
  def create
    order = Order.find_by(id: params[:order_id])
    order.update(address: params[:order][:address], phone: params[:order][:phone]) if order.present?
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          unit_amount: (order.subtotal.to_i * 100) / 83,
          product_data: {
            name: 'all product',
          },
        },
        quantity: 1,
      }],
      success_url: "https://0650-115-246-79-60.ngrok-free.app/completion",
      cancel_url: "https://0650-115-246-79-60.ngrok-free.app/",
      mode: 'payment',
    )
    redirect_to @session['url'], allow_other_host: true
  end
end