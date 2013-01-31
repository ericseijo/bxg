include ApplicationHelper

#def valid_signin(user)
#  fill_in "Email",    with: user.email
#  fill_in "Password", with: user.password
#  click_button "Sign in"
#end

def sign_in(user)
  # visit signin_path
  # fill_in "Email",    with: user.email
  # fill_in "Password", with: user.password
  # click_button "Sign in"
  # Sign in when not using Capybara as well.
  #cookies[:remember_token] = user.remember_token
  #post login_path, :login => user.login, :password => 'password'
  #post_via_redirect user_session_path, 'user[email]' => user.email, 'user[password]' => user.password
  visit new_user_session_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def last_email
  ActionMailer::Base.deliveries.last
end

def reset_email
  ActionMailer::Base.deliveries = []
end

def select_date(date, options = {})
  field = options[:from]
  select date.year.to_s,   :from => "#{field}_1i"
  select Date::MONTHNAMES[date.month], :from => "#{field}_2i"
  select date.day.to_s,    :from => "#{field}_3i"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    page.should have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :be_the_same_time_as do |expected|
  match do |actual|
    expected.to_i == actual.to_i
  end
end
