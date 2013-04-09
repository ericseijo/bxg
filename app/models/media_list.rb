class MediaList < ActiveRecord::Base
  attr_accessible :address, :circulation, :city, :company, :email, :fax, :phone, :state, :url, :zip

  validates :company, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }


  def self.add_new_media_contact(company, address, city, state, zip, phone, fax, circulation, url, email)
    if MediaList.find_by_company_and_email(company, email).blank?
      MediaList.create(company: company, address: address, city: city, state: state, zip: zip, phone: phone, fax: fax, circulation: circulation, url: url, email: email)
    end
  end

  def self.find_matches_for(distribution_list)
    ## DistributionList
    #name "List"
    #where "US"
    #where_area "Northeast"
    #who "Newspapers"
    #who_sub "New York Times"
    #what "Music"
    #what_sub "Jazz"
    #
    #
    ## MediaList
    #company "Huffington Post"
    #address "1234 My St."
    #city "New York"
    #state "NY"
    #zip "10029"
    #phone "212-555-1212"
    #fax "212-555-1213"
    #circulation "66.4"
    #url "http://www.huffingtonpost.com"
    #email

    # TODO: need to add country and region  as well as who, who_sub and what_sub to MediaList
    self.where(criteria_for(distribution_list))
  end

  def self.criteria_for(distribution_list)
    if distribution_list.where_area == "all"
      "state IN(#{DistributionList::US_STATES.map {|str| "\'#{str}\'"}.join(',')})"
    else
      "state = '#{distribution_list.where_area}'"
    end
  end
end

