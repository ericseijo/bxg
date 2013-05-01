class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :company_name
  attr_accessible :address, :address_2, :city, :state, :zip, :country


  has_one :subscription
  has_many :releases
  has_many :clients

  def full_name
  	[first_name, last_name].join(' ')
  end

  def is_an_active_member?
    self.try(:subscription).try(:status) == 'Subscriber' || self.try(:subscription).try(:status) == 'trial'
  end

  def is_a_valid_subscriber?
    self.try(:subscription).try(:status) == 'Subscriber'
  end

  def is_a_trial_subscriber?
    self.try(:subscription).try(:status) == 'trial'
  end

  def subscription_level
    subscription = self.try(:subscription).try(:plan).try(:level)
    status = self.try(:subscription).try(:status)
    [subscription, status].join(' ')
  end

end
