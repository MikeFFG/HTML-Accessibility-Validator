require 'trollop'

require_relative 'email_reports'
require_relative 'accessibility_validator'
require_relative 'html_validator'

# Coordinate running of html and accessibility validators
class ValidationRunner
  attr_accessor :command_line_options

  def initialize
  end

  def parse_command_line
    @command_line_options = Trollop.options do
      opt :url, 'Enter URL for testing', type: :string
    end
  end

  def write_to_file(data)
    File.write('logs/testfile.json', data)
  end

  def run_html_val

  end

  def run_access_val

  end

  # Run stuff
  def run
    parse_command_line
    access_validator = AccessibilityValidator.new(command_line_options)
    access_validator.run_validator
    # html_validator = HTMLValidator.new(command_line_options)
    # json_response = html_validator.request_to_json

    # write_to_file(JSON.pretty_generate(json_response))

    # email = Email.new('logs/testfile.json')
    # Mail.defaults do
      # delivery_method :smtp, email.options
    # end
    # email.send
  end
end

validation_runner = ValidationRunner.new
validation_runner.run

