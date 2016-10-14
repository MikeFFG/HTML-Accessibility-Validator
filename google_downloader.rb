require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Google Sheets API Ruby Quickstart'.freeze
CLIENT_SECRETS_PATH = 'client_secret.json'.freeze
SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS_READONLY
CREDS_PATH = File.join(Dir.home, '.credentials',
                       'sheets.googleapis.com-ruby-quickstart.yaml')
                 .freeze
SPREADSHEET_ID = '1PRqzAK8M2qPhV2navyistU41cvfVjZL3W0iWClF0h5M'.freeze
RANGE = 'Client List!A2:E'.freeze

# Goes to https://docs.google.com/spreadsheets/d/1PRqzAK8M2qPhV2navyistU41cvfVjZL3W0iWClF0h5M/edit#gid=0
# to get data and provide it for validation runs.
class GoogleDownloader
  ##
  # Ensure valid credentials, either by restoring from the saved credentials
  # files or intitiating an OAuth2 authorization. If authorization is required,
  # the user's default browser will be launched to approve the request.
  #
  # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
  def authorize
    FileUtils.mkdir_p(File.dirname(CREDS_PATH))

    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDS_PATH)

    authorizer = Google::Auth::UserAuthorizer.new(
      client_id, SCOPE, token_store
    )

    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    no_credentials if credentials.nil?
    credentials
  end

  def no_credentials
    url = authorizer.get_authorization_url(
      base_url: OOB_URI
    )

    puts 'Open the following URL in the browser and enter the ' \
         'resulting code after authorization'
    puts url
    code = gets
    authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end

  def initialize_api
    # Initialize the API
    service = Google::Apis::SheetsV4::SheetsService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize
    service
  end

  def run_downloader
    service = initialize_api

    # My code
    response = service.get_spreadsheet_values(SPREADSHEET_ID, RANGE)
    puts 'No data found.' if response.values.empty?
    response_array = []

    response.values.each do |row|
      site_to_test = { client: row[0], url: row[1], depth: row[2],
                       follow: row[3], ruleset: row[4] }
      response_array << site_to_test
    end

    response_array
  end
end
