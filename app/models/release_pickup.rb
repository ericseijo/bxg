class ReleasePickup < ActiveRecord::Base
  attr_accessible :media_list_id, :release_id

  belongs_to :release
  belongs_to :media_list

  validates :media_list_id, presence: true
  validates :release_id, presence: true
end
