class StripeController < ApplicationController

  def charge
    @driver = User.find_by(username: payment_params[:user])
    @purchase = Purchase.find_or_create_by(:buyer => current_user, :driver => @driver)
    unless @purchase.bought?
      @purchase.attempt_to_buy!
    else
      flash[:notice] = "Details already purchased."
      redirect_to user_path(username: @driver.username) and return
    end

    Stripe.api_key = "sk_test_j42oA8TbOvtNtHh0KjVCXlyE"
    token = payment_params[:stripeToken]

    begin
      customer_id = current_user.stripe_customer_id
      if customer_id
        Stripe::Charge.create(
          :amount   => 2000,
          :currency => "gbp",
          :customer => customer_id
        )
      else
        # Create a Customer
        customer = Stripe::Customer.create(
          :card => token,
          :description => current_user.username
        )

        Stripe::Charge.create(
            :amount => 2000,
            :currency => "gbp",
            :customer => customer.id
        )

        save_stripe_customer_id(customer.id)
      end
    rescue Stripe::CardError => e
      @purchase.purchase_has_failed!
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
      flash[:notice] = "Unable to purchase details."
    end
    @purchase.success!
    flash[:notice] = "Details purchased."
    redirect_to user_path(username: @driver.username)
  end

  private

  def payment_params
    params.permit(:stripeToken, :user)
  end

  def save_stripe_customer_id id
    current_user.stripe_customer_id = id
    current_user.save!
  end

end
