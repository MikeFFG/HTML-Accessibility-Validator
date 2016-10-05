require 'trollop'

require_relative 'email_reports'
require_relative 'accessibility_validator'
require_relative 'html_validator'

# Coordinates running of html and accessibility validators
class ValidationRunner
  attr_accessor :command_line_options

  def initialize
  end

  def parse_command_line
    @command_line_options = Trollop.options do
      opt :url, 'Enter URL for testing', type: :string
      opt :title, 'Enter title for tests', type: :string
    end
  end

  def write_to_file(data)
    File.write('logs/html_data.json', data)
  end

  def append_to_file(data, file)
    temp = JSON.parse(File.read(file))
    temp.push(data)
    target_file = open(file, 'w+')
    target_file.write(JSON.pretty_generate(temp))
    target_file.close
  end

  def run_html_val
  end

  def run_access_val
  end

  def email_report
    email = Email.new('logs/testfile.json')
    Mail.defaults do
      delivery_method :smtp, email.options
    end
    email.send
  end

  # Run stuff
  def run
    parse_command_line
    # access_validator = AccessibilityValidator.new(command_line_options)
    # access_validator.run_validator

    html_validator = HTMLValidator.new(command_line_options)
    json_response = html_validator.request_to_json
    # puts json_response.class
    # puts JSON.pretty_generate(json_response)

    append_to_file(json_response, 'logs/html_data.json')

    # email_report
  end
end

validation_runner = ValidationRunner.new
validation_runner.run
