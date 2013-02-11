class Client < ActiveRecord::Base
  attr_accessible :name, :ticker_symbol, :user_id, :website

  belongs_to :user
  has_one :logo, :as => 'assetable', :class_name => 'Asset', :dependent => :destroy

  validates :user_id, presence: true
  validates :name, presence: true
end
