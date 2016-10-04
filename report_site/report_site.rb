require 'sinatra'
require "sinatra/content_for"
require "sinatra/reloader"
require "tilt/erubis"
require 'json'

ACCESS_VAL_LOC = '/report_site/data/accessibility_validation_sample.json'
HTML_VAL_LOC = '/report_site/data/html_validation_sample.json'
ACCESS_VAL_LOC2 = '/logs/accessibility_data.json'
HTML_VAL_LOC2 = '/logs/html_data.json'

class Data

end

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

helpers do
  def get_single_site_access_violations(index)
    return session[:access_vals_all][index]["page_eval_rule_results"].select do |result|
      result['fields']['elements_violation'] > 0
    end
  end

  def get_single_site_html_violations(index)
    session[:html_vals_all][index]
  end

  def read_html_data_from_logs
    JSON.parse(File.read(Dir.pwd + HTML_VAL_LOC2))
  end

  def read_access_data_from_logs
    JSON.parse(File.read(Dir.pwd + ACCESS_VAL_LOC2))
  end
end

before do
  session[:index] ||= 0
  session[:site_tabs] = ["title1", "title2", "title"]
  session[:access_vals_all] = read_access_data_from_logs
  session[:html_vals_all] = read_html_data_from_logs
end

get '/' do
  @site_tabs = session[:site_tabs] # temp

  redirect "/1"
end

get '/:id' do
  index = params[:id].to_i
  @site_tabs = session[:site_tabs] # temp
  @access_val = get_single_site_access_violations(index)
  @html_val = get_single_site_html_violations(index)

  erb :table
end
