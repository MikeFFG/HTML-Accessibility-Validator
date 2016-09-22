require 'selenium-webdriver'
require 'mail'
require 'net/smtp'
require 'pry'
require 'sudo'

require_relative 'emailReports'

class AccessibilityValidator

end
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

# Email report
# email = Email.new('/Users/mike/Downloads/achecker_2016-09-21_20-10-49.pdf')
# Mail.defaults do
#   delivery_method :smtp, email.options
# end
# email.send

# Copy report to logs
logsDir = Dir.pwd + "/logs"
file = Dir.glob("/users/mike/Downloads/achecker_*").max_by {|f| File.mtime(f)}
FileUtils.mv(file, logsDir, options = { :force => true})
