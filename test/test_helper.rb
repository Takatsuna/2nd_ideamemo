require "simplecov"
SimpleCov.start "rails"

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

require "capybara/rails"
require "fileutils"

class AcceptanceTest < ActionDispatch::IntegrationTest
 include Capybara::DSL
 include FileUtils
 SCREENSHOTS_DIR = "screenshot"
 self.use_transactional_fixtures = false
 
 #てすとじっこうまえ
 setup do
  Capybara.register_driver :selenium_firefox do |app|
   Capybara::Selenium::Driver.new(app,browser: :firefox)
  end
  Capybara.default_driver = :selenium_firefox
  
  Capybara.default_wait_time = 60
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.start
  page.driver.browser.manage.window.maximize
 end

#てすとしゅうりょうご
 teardown do
  DatabaseCleaner.clean
 end

#すくりーんしょっと
 def save_screenshot(fname)
    unless Capybara.default_driver == :rake_test
        mkdir_p SCREENSHOTS_DIR
        sleep 1
        super(File.join(SCREENSHOTS_DIR,fname))
    end
 end


#ぶらうざひょうじさいずへんこう
 def ensure_browser_size(width = 600,height = 480)
    Capybara.current_session.driver.browser.manage.window.resize_to(width,height)
 end

 private
  def visit_root
    visit root_path
    ensure_browser_size
    assert_equal new_user_session_path, current_path
  end



  def sign_out
    click_link "Logout"
    assert_equal new_user_session_path, current_path
  end

end

 