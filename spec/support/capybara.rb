require 'capybara/rspec'
require 'selenium-webdriver'

# ChromeDriverを利用するように変更
# 利用時にヘッドレスモードで起動
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
                                   chrome_options: {
                                     args: %w(headless disable-gpu window-size=1680,1050),
                                   },
                                 ))
end
Capybara.javascript_driver = :selenium
