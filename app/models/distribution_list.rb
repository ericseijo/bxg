class DistributionList < ActiveRecord::Base
  attr_accessible :what, :what_sub, :where, :where_area, :who, :who_sub, :name

  validates :release_id, presence: true
  validates :name, presence: true


  COUNTRY_OR_REGION = [ ['International', 'International'],
                        ['USA', 'USA'],
                        ['Europe', 'Europe'],
                        ['Asia', 'Asia'] ]

  MEDIA_TYPE = [ ['All Media', 'All'],
                 ['Radio', 'Radio'],
                 ['Magazine', 'Magazine'],
                 ['Television', 'Television'] ]

  MEDIA_SUB_GENRE = [ ['News', 'News'],
                      ['Daily', 'Daily'],
                      ['All', 'All'] ]

  PRIMARY_SUBJECT = [ ['Business', 'Business'],
                      ['Health', 'Health'] ]

  NICHE = [ ['Markets', 'Markets'],
            ['Diet & Nutrition', 'Diet & Nutrition'] ]

  US_STATES = ['AK', 'AL', 'AR', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME', 'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV', 'NY', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VA', 'VT', 'WA', 'WI', 'WV', 'WY']

end
