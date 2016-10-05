require 'selenium-webdriver'
require 'net/smtp'
require 'net/http'
require 'uri'
require 'open-uri'
require 'sudo'
require 'pry'

require_relative 'email_reports'

# Runs Accessibility Validator at http://fae20.cita.illinois.edu/
class AccessibilityValidator
  def initialize(options)
    @options = options
    @title = @options[:title] || 'Untitled'
  end

  def strip_http(url)
    url.sub(%r{https*:\/\/}, '')
  end

  def instantiate_browser
    # Chrome browser instantiation
    @driver = Selenium::WebDriver.for :chrome
  end

  def navigate_to_page
    # Navigate to accessibility checker
    @driver.navigate.to 'http://fae20.cita.illinois.edu/login/'
  end

  def enter_credentials
    # Log in
    @driver.find_element(:id, 'id_username').send_keys('pixo.qa')
    @driver.find_element(:id, 'id_password').send_keys('P9cTntdXK2')
    @driver.find_element(:css, "input[type='submit']").click
  end

  def enter_query_info
    # Enter info and click
    @driver.find_element(:id, 'id_input_url').send_keys(strip_http(@options[:url]))
    @driver.find_element(:id, 'id_input_title').send_keys(@title)
    @driver.find_element(:id, 'depth_1').click
    @driver.find_element(:id, 'id_submit').click
  end

  def navigate_to_archived_reports
    # Wait for processing to finish before going to Archived Reports
    wait = Selenium::WebDriver::Wait.new(timeout: 60)
    begin
      wait.until { @driver.find_element(link_text: @title) }
    end
    @driver.find_element(link_text: 'Archived Reports').click
  end

  def quit_browser
    @driver.quit
  end

  def read_json_data
    # Grab the href of the link in the first row, last cell of the reports
    # table. It should be the JSON link.
    css_id = '#id_table_reports tbody tr:first-of-type td:last-of-type a'
    json_link = @driver.find_element(:css, css_id).attribute('href')

    # Read json from link and write to Ruby hash
    returned_data = JSON.parse(open(json_link, &:read))

    # Make pretty JSON
    json_data = JSON.pretty_generate(returned_data)
  end

  def run_validator
    instantiate_browser
    navigate_to_page
    enter_credentials
    enter_query_info
    navigate_to_archived_reports
    read_json_data
    quit_browser
  end
end

# Copy report to logs
# logs_dir = Dir.pwd + '/logs'
# file = Dir.glob('/users/mike/Downloads/achecker_*').max_by do |f|
#   File.mtime(f)
# end
# FileUtils.mv(file, logs_dir, force: true)
