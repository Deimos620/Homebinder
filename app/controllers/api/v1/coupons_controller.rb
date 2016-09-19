class Api::V1::CouponsController < Api::V1::ApiController
  require 'stripe'
  
  def show
    begin
      @coupon = Stripe::Coupon.retrieve(params[:id]) 
      
      render json: @coupon
 
      rescue Stripe::CardError => e
        # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err  = body[:error]
        
        render json: "#{err[:message].titleize}", status: :unprocessable_entity 
      rescue Stripe::InvalidRequestError => e
        # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err  = body[:error]
        
        render json: "#{err[:message].titleize}", status: :unprocessable_entity
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        render json: "We're having trouble processing your request. Try again later.", status: :unprocessable_entity
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
        render json: "We're having trouble processing your request. Try again later.", status: :unprocessable_entity
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        render json: "We're having trouble processing your request. Try again later.", status: :unprocessable_entity
    end
  end
end
