ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'turn'

DatabaseCleaner.strategy = :truncation

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def teardown
    DatabaseCleaner.clean
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

  protected
  def login(user)
    visit login_path
    fill_in 'E-mail', with: user.email
    fill_in 'Senha',  with: user.password
    click_on 'Acessar'
  end

  def logout
    click_on 'Sair'
  end

  def with(user)
    login user
    yield
    logout
  end

  def assert_false(value, msg="")
    assert !value, msg
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all

  # Add more helper methods to be used by all tests here...
end
