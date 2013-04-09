FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    first_name "Eric"
    last_name "Seijo"
    company_name "Codephreak Technologies, Inc."
    email    "eric@codephreak.com"
    password "foobar"
    password_confirmation "foobar"
    admin false
  end
  
  factory :plan do
    level "Basic"
    price "299.99"
    number_of_releases_per_month "5"
    storage_space "20 GB"
    number_of_user_accounts "10"
    description "You can do lots"
    active true
  end

  factory :subscription do
    user_id "1"
    plan_id "1"
    status "Trial"
  end

  factory :release do
    user_id "1"
    client_id "1"
    name "Release 1"
    status "Active"
    headline "Here's the new release"
    sub_headline "Sub headline"
    body "Body text"
    link "http://www.example.com"
    publish_date Time.now
  end

  factory :client do
    user_id "1"
    name "Client 1"
    ticker_symbol "CLI1"
    website "http://www.example.com"
  end

  factory :distribution_list do
    release_id "1"
    name "List"
    where "US"
    where_area "Northeast"
    who "Newspapers"
    who_sub "New York Times"
    what "Music"
    what_sub "Jazz"
  end

  factory :media_list do
    company "Huffington Post"
    address "1234 My St."
    city "New York"
    state "NY"
    zip "10029"
    phone "212-555-1212"
    fax "212-555-1213"
    circulation "66.4"
    url "http://www.huffingtonpost.com"
    email
  end

end