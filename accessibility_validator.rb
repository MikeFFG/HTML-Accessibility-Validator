require 'selenium-webdriver'
require 'mail'
require 'net/smtp'
require 'net/http'
require 'uri'
require 'open-uri'
require 'pry'
require 'sudo'








# uri = URI.parse("https://fae.disability.illinois.edu/")

# http = Net::HTTP.post_form(uri, {
    # "url" => "http://www.google.com",
    # "title" => "test"
#   });
# request = Net::HTTP::Get.new(uri.request_uri)

# response = http.request(request)

# http = Net::HTTP.new(uri.host, uri.port)

# request = Net::HTTP::Post.new(uri.request_uri)
# request.add_field("Referer", "https://fae.disability.illinois.edu/")
# request.add_field("Debug", "true")
# request.set_form_data({
#   "url" => "http://www.google.com",
#   "title" => "test",
# });
# request.basic_auth("qa@pixotech.com", "P9cTntdXK2")
# http.use_ssl = true
# http.verify_mode = OpenSSL::SSL::VERIFY_NONE
# response = http.request(request);


# puts response.body



# uri = URI('https://fae.disability.illinois.edu/')
# res = Net::HTTP.new(uri, p_user='qa@pixotech.com', p_pass='P9cTntdXK2')
# res.start
# res = Net::HTTP.post_form(uri, 'url' => 'http://www.google.com', 'submit' => 'Evaluate' )
# p res

# req = Net::HTTP::Post.new('https://fae.disability.illinois.edu/')

# req.set_form_data({
#   'url'    => 'http://www.google.com',
#   'submit' => 'Evaluate'
#   })
# res = Net::HTTP.new(uri.host, uri.port, p_user='qa@pixotech.com', p_pass='P9cTntdXK2').start { |http| http.request(req) }
# p res
# File.open('out.htm', 'w') { |f| f.write res.body }

# require_relative 'email_reports'

# # class AccessibilityValidator

# # end

# title = 'test'
# # # Chrome browser instantiation
# driver = Selenium::WebDriver.for :chrome

# # # Navigate to accessibility checker
# driver.navigate.to "http://fae20.cita.illinois.edu/login/"

# driver.find_element(:id, 'id_username').send_keys('pixo.qa')
# driver.find_element(:id, 'id_password').send_keys('P9cTntdXK2')
# driver.find_element(:css, "input[type='submit']").click

# # # Enter info and click
# driver.find_element(:id, 'id_input_url').send_keys('www.michaeldburke.net')
# driver.find_element(:id, 'id_input_title').send_keys(title)
# driver.find_element(:id, 'depth_1').click
# driver.find_element(:id, 'id_submit').click

# wait = Selenium::WebDriver::Wait.new(timeout: 60)
# begin
#   element = wait.until { driver.find_element(:link_text => title) }
# end
# driver.find_element(:link_text => 'Archived Reports').click
file_contents = open('http://fae20.cita.illinois.edu/report/15758eb303059acb/json/') {|f| f.read}
File.open('logs/test.json', 'w') { |file| file.write(JSON.pretty_generate(file_contents)) }
# driver.find_element(:id, 'validate_file_button').click

# # Wait 10 seconds (will make this smarter later)
# sleep(20)

# # Quitting the browser
# driver.quit

# # Email report
# # email = Email.new('/Users/mike/Downloads/achecker_2016-09-21_20-10-49.pdf')
# # Mail.defaults do
# #   delivery_method :smtp, email.options
# # end
# # email.send

# # Copy report to logs
# # logs_dir = Dir.pwd + '/logs'
# # file = Dir.glob('/users/mike/Downloads/achecker_*').max_by { |f| File.mtime(f) }
# # FileUtils.mv(file, logs_dir, force: true)
