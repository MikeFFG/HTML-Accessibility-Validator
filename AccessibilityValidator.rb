require 'selenium-webdriver'
require 'mail'
require 'net/smtp'


# # Chrome browser instantiation
# driver = Selenium::WebDriver.for :chrome

# # Navigate to accessibility checker
# driver.navigate.to "http://achecker.ca/checker/index.php"

# # Enter info and click
# driver.find_element(:id, 'checkuri').send_keys('http://www.google.com')
# driver.find_element(:id, 'validate_uri').click

# # Wait 10 seconds (will make this smarter later)
# sleep(10)

# driver.find_element(:id, 'validate_file_button').click

# # Wait 10 seconds (will make this smarter later)
# sleep(10)

# # Quitting the browser
# driver.quit


# email me report
options = { :address => "smtp.gmail.com",
            :port => 587,
            :user_name => 'pixoqainternal@gmail.com',
            :password => 'iZotope1986',
            :authentication => 'plain',
            :enable_starttls_auto => true
}

Mail.defaults do
  delivery_method :smtp, options
end

mail = Mail.new do
  from 'qa@pixotech.com'
  to 'mike@pixotech.com'
  subject 'test'
  body 'test'
end

mail.add_file('/Users/mike/Downloads/achecker_2016-09-21_20-10-49.pdf')

mail.deliver
