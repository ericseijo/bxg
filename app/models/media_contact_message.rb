class MediaContactMessage < ActiveRecord::Base
  attr_accessible :media_list_id, :message, :release_id, :originator

  belongs_to :media_list
  belongs_to :release

  validates :media_list_id, :message, :release_id, :originator, presence: true


  ORIGIN = { :user => 'user', :media_contact => 'media_contact' }

end
