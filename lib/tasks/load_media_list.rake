desc "load media list"

namespace :db do
  DATA_DIRECTORY = "#{Rails.root}/lib/tasks/load_data"
  csv_file = 'media_list.csv'
  complete_file_with_path = File.join(DATA_DIRECTORY, csv_file)

  task :load_list => :environment do
    require 'csv'

    CSV.foreach(complete_file_with_path, :headers => true, :header_converters => :symbol) do |row|
      #newspaper, address, city, state, zip, phone, fax, circ, url, email
      MediaList.add_new_media_contact(row[:newspaper], row[:address], row[:city], row[:state], row[:zip], row[:phone], row[:fax], row[:circ], row[:url], row[:email])
    end
  end

end