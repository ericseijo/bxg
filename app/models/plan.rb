class Plan < ActiveRecord::Base
  attr_accessible :active, :description, :level, :number_of_releases_per_month, :number_of_user_accounts, :price, :storage_space

  has_many :subscriptions

  validates :description, presence: true
  validates :level, presence: true
  validates :number_of_releases_per_month, presence: true, numericality: true
  validates :number_of_user_accounts, presence: true, numericality: true
  validates :price, presence: true, numericality: true
  validates :storage_space, presence: true

  scope :all_active, where(:active => true)

end
