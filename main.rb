require 'trollop'

require_relative 'email_reports'
require_relative 'accessibility_validator'
require_relative 'html_validator'

ACCESS_VAL_DATA_PATH = 'logs/accessibility_data.json'
HTML_VAL_DATA_PATH = 'logs/html_data.json'

# Coordinates running of html and accessibility validators
class ValidationRunner
  attr_accessor :command_line_options

  def initialize
  end

  def parse_command_line
    @command_line_options = Trollop.options do
      opt :url, 'Enter URL for testing', type: :string
      opt :title, 'Enter title for tests', type: :string
      opt :clear, 'Clears previous logs'
    end
  end

  # def write_to_file(data)
  #   File.write('logs/html_data.json', data)
  # end

  def file_empty?(file)
  end

  def append_to_file(data, file)
    # if file_empty?(file)

    # end

    temp = JSON.parse(File.read(file))
    temp.push(data)
    target_file = open(file, 'w+')
    target_file.write(JSON.pretty_generate(temp))
    target_file.close
  end

  def clear_log_file(file)
    log_file = open(file, 'w+')
    log_file.write('[]')
    log_file.close
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

    if command_line_options[:clear]
      clear_log_file(ACCESS_VAL_DATA_PATH)
      clear_log_file(HTML_VAL_DATA_PATH)
    end

    # Access val
    access_validator = AccessibilityValidator.new(command_line_options)
    access_data = access_validator.run_validator
    append_to_file(access_data, ACCESS_VAL_DATA_PATH)

    # HTML Val
    html_validator = HTMLValidator.new(command_line_options)
    json_response = html_validator.request_to_json
    append_to_file(json_response, HTML_VAL_DATA_PATH)
  end
end

validation_runner = ValidationRunner.new
validation_runner.run
