class Release < ActiveRecord::Base
  attr_accessible :body, :headline, :link, :name, :publish_date, :status, :sub_headline

  belongs_to :user
  belongs_to :client
  has_many :assets, :as => 'assetable', :dependent => :destroy

  validates :user_id, presence: true
  validates :name , presence: true
  validates :status, presence: true

  STATUS = { :active => 'active', :pending => 'pending', :inactive => 'inactive' }
end
