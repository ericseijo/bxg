class Subscription < ActiveRecord::Base
  attr_accessible :status, :plan_id, :user_id, :stripe_card_token, :user_name

  attr_accessor :stripe_card_token, :user_name

  belongs_to :user
  belongs_to :plan

  validates :user_id, :presence => true
  validates :plan_id, :presence => true
  validates :status, :presence => true


  def save_with_payment_for(user)

    if valid?
      customer = Stripe::Customer.create(description: "Subscription for #{user.full_name} - #{user.email}", plan: plan_id, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      self.status = 'Subscriber'
      save!
      UserMailer.new_subscriber(user).deliver
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def update_subscription_level_to(new_plan)
    customer = Stripe::Customer.retrieve(self.stripe_customer_token)
    if customer && new_plan
      customer.update_subscription(:plan => new_plan.id)
      self.plan = new_plan
      self.save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem updating your subscription."
    false
  end

  def cancel
    customer = Stripe::Customer.retrieve(self.stripe_customer_token)
    if customer
      customer.cancel_subscription
      self.status = "canceled"
      self.canceled_at = Time.now
      self.save!
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem updating your subscription."
    false
  end

  def self.create_trial_for(user, plan)
    if valid?
      subscription = Subscription.new(:plan_id => plan.id)
      subscription.user_id = user.id
      subscription.status = 'trial'
      subscription.save!
    end
    rescue ActiveRecord::RecordInvalid
      false
  end

end
