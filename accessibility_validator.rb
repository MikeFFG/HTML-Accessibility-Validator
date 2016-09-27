require 'selenium-webdriver'
require 'mail'
require 'net/smtp'
require 'net/http'
require 'uri'
require 'open-uri'
require 'pry'
require 'sudo'

require_relative 'email_reports'

title = 'test'
# Chrome browser instantiation
driver = Selenium::WebDriver.for :chrome

# Navigate to accessibility checker
driver.navigate.to "http://fae20.cita.illinois.edu/login/"

# Log in
driver.find_element(:id, 'id_username').send_keys('pixo.qa')
driver.find_element(:id, 'id_password').send_keys('P9cTntdXK2')
driver.find_element(:css, "input[type='submit']").click

# Enter info and click
driver.find_element(:id, 'id_input_url').send_keys('www.google.com')
driver.find_element(:id, 'id_input_title').send_keys(title)
driver.find_element(:id, 'depth_1').click
driver.find_element(:id, 'id_submit').click

# Wait for processing to finish before going to Archived Reports
wait = Selenium::WebDriver::Wait.new(timeout: 60)
begin
  element = wait.until { driver.find_element(:link_text => title) }
end
driver.find_element(:link_text => 'Archived Reports').click
json_link = driver.find_element(:css, "#id_table_reports tbody tr:first-of-type td:last-of-type a").attribute("href")

# Read json from link and write to Ruby hash
returned_data = JSON.parse(open(json_link) { |f| f.read })

# Make pretty JSON
json_data = JSON.pretty_generate(returned_data)
puts json_data

# Quitting the browser
driver.quit


# # Copy report to logs
# # logs_dir = Dir.pwd + '/logs'
# # file = Dir.glob('/users/mike/Downloads/achecker_*').max_by { |f| File.mtime(f) }
# # FileUtils.mv(file, logs_dir, force: true)
