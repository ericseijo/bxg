FactoryGirl.define do
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

end