class Api::V1::SubscriptionsController < Api::V1::ApiController
  require 'stripe'
  
  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscription_wrappers = Array.new
    if params[:user].nil?
      binder = Binder.find(params[:binder_id])
      @subscription_wrappers << SubscriptionWrapper.new(binder)
    else
      binders = @current_user.binders.includes(:subscription).where(:active => true)
      binders.each do |b|
        @subscription_wrappers << SubscriptionWrapper.new(b)
      end
    end
    puts @subscription_wrappers
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find(params[:id])
    @binder = Binder.find(@subscription.binder_id)
    
    @ability.authorize! :subscribe, @binder
    
    @subscription_wrapper = SubscriptionWrapper.new(@binder)
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.json
  def update
    @subscription = Subscription.find(params[:id])
    @binder = Binder.find(@subscription.binder_id)
    @action = params[:subscription_action]
    @card = params[:card].nil? ? nil : params[:card]
    @coupon = params[:coupon].nil? ? nil : params[:coupon]
    
    @ability.authorize! :subscribe, @binder

    begin
        SubscriptionService.update_subscription(@action, @subscription, @card, @coupon)
        @subscription_wrapper = SubscriptionWrapper.new(@binder)
      rescue Stripe::CardError => e
        # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err  = body[:error]
          
        #render :json => "#{err[:message].titleize}", :status => :unprocessable_entity
        render :json => "Invalid credit card", :status => :unprocessable_entity
      rescue Stripe::InvalidRequestError => e
        # Since it's a decline, Stripe::CardError will be caught
        body = e.json_body
        err  = body[:error]
          
        render :json => "#{err[:message].titleize}", :status => :unprocessable_entity
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        render :json => "We're having trouble processing your request. Try again later.", :status => :unprocessable_entity 
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
        render :json => "We're having trouble processing your request. Try again later.", status => :unprocessable_entity 
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        render :json => "We're having trouble processing your request. Try again later.", status => :unprocessable_entity
      rescue CardRequiredException => e
        render :json => e.message, :status => :unprocessable_entity
      rescue UnprocessableException => e
        render :json => @subscription.errors, :status => :unprocessable_entity
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    head :no_content
  end

end
