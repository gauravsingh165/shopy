class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
      
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    # event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, Rails.application.credentials[:stripe][:webhook]
      )
  
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature error"
      p e
      return
    end
    puts "$#{event}"

  
    case event.type
    when 'checkout.session.completed'
      
      session_amount_total = BigDecimal(event.data.object.amount_total)
        @product = Product.find_by(price: session_amount_total) || Product.new(price: session_amount_total)
      if @product.save
        @product.update(cotegory: 'payment Done')
      else
        puts "Error saving product: #{product.errors.full_messages.join(', ')}"
      end
    end
  
  
    render json: { message: 'success' }
  end
  end