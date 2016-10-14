require 'trollop'

require_relative 'email_reports'
require_relative 'accessibility_validator'
require_relative 'html_validator'
require_relative 'google_downloader'

ACCESS_VAL_DATA_PATH = 'logs/accessibility_data.json'.freeze
HTML_VAL_DATA_PATH = 'logs/html_data.json'.freeze

# Coordinates running of html and accessibility validators
class ValidationRunner
  attr_accessor :command_line_options

  def parse_command_line
    @command_line_options = Trollop.options do
      opt :url, 'Enter URL for testing', type: :string
      opt :title, 'Enter title for tests', type: :string
      opt :clear, 'Clears previous logs'
      opt :auto, 'Use google drive spreadsheet'
    end
  end

  def append_to_file(data, file)
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

  def email_report
    email = Email.new('logs/testfile.json')
    Mail.defaults do
      delivery_method :smtp, email.options
    end
    email.send
  end

  def run_google_downloader
    # Run google downloader
    downloader = GoogleDownloader.new
    downloader.run_downloader
  end

  def run_html_val(site_data)
    html_validator = HTMLValidator.new(site_data)
    json_response = html_validator.request_to_json
    append_to_file(json_response, HTML_VAL_DATA_PATH)
  end

  def run_access_val(site_data)
    access_validator = AccessibilityValidator.new(site_data)
    access_data = access_validator.run_validator
    append_to_file(access_data, ACCESS_VAL_DATA_PATH)
  end

  def single_iteration(single_site_data)
    run_html_val(single_site_data)
    run_access_val(single_site_data)
  end

  def clear_logs
    clear_log_file(ACCESS_VAL_DATA_PATH)
    clear_log_file(HTML_VAL_DATA_PATH)
  end

  # Run everything
  def run
    parse_command_line
    clear_logs if command_line_options[:clear]

    # Choose between auto google sheet data and cli data
    if command_line_options[:auto]
      clear_logs
      multi_site_data = run_google_downloader

      multi_site_data.each do |single_site_data|
        single_iteration(single_site_data)
      end
    else
      single_site_data = { title: command_line_options[:title] || 'Untitled',
                           url: command_line_options[:url] }
      single_iteration(single_site_data)
    end
  end
end

validation_runner = ValidationRunner.new
validation_runner.run
