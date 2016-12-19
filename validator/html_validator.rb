require 'net/http'
require 'uri'
require 'json'
require 'csv'

# Runs HTML validation at http://validator.w3.org/nu/ on given url
class HTMLValidator
  attr_reader :csv_string

  def initialize(options)
    @options = options
  end

  # Returns response object given the url to test
  def http_request(url_to_validate)
    uri = URI('http://validator.w3.org/nu/')
    request_params = {
      doc: url_to_validate,
      out: 'json'
    }
    uri.query = URI.encode_www_form(request_params)
    Net::HTTP.get_response(uri)
  end

  # Converts response object to JSON and returns it
  def response_to_json(response)
    JSON.parse(response.body)
  end

  # Make request
  def request_to_json
    response_to_json(http_request(@options[:url]))
  end

  # Output to CSV
  def json_to_csv(json_hash)
    @csv_string = CSV.generate do |csv|
      json_hash['messages'].each do |message|
        csv << [message['type'], message['lastLine'], message['message']]
      end
    end
  end
end
