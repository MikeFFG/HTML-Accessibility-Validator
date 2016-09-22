require 'net/http'
require 'uri'
require 'json'
require 'csv'
require 'pry'
require 'trollop'

class HTMLValidator

end

# Returns response object given the url to test
def HTTPRequest(url)
  uri = URI('http://validator.w3.org/nu/')
  requestParams = {
    :doc => url,
    :out => 'json'
  }
  uri.query = URI.encode_www_form(requestParams)
  Net::HTTP.get_response(uri)
end

# Converts response object to JSON and returns it
def ResponseToJSON(response)
  JSON.parse(response.body)
end

# Parse command line
commandLineOptions = Trollop::options do
  opt :url, "Enter URL for testing", :type => :string
end

# Make request
response = HTTPRequest(commandLineOptions[:url])
jsonHash = ResponseToJSON(response)

# Output to CSV
csv_string = CSV.generate do |csv|
  jsonHash["messages"].each do |message|
      csv << [message["type"], message["lastLine"], message["message"]]
  end
end

puts csv_string
