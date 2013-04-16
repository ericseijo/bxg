class Release < ActiveRecord::Base
  attr_accessible :body, :headline, :link, :name, :publish_date, :status, :sub_headline

  belongs_to :user
  belongs_to :client
  has_many :assets, :as => 'assetable', :dependent => :destroy
  has_many :distribution_lists, :dependent => :destroy

  validates :user_id, presence: true
  validates :name , presence: true
  validates :status, presence: true

  STATUS = { :active => 'active',
             :pending => 'pending',
             :inactive => 'inactive',
             :submitted => 'submitted',
             :approved => 'approved',
             :query_user => 'query_user'}

  def deliver_to_media
    distribution_lists = self.distribution_lists

    distribution_lists.each do |distribution_list|
      media_contacts = MediaList.find_matches_for(distribution_list)
      media_contacts.each do |media_contact|
        ReleaseMailer.deliver_release(self, self.user.email, media_contact.email)
      end
    end
  end

end
