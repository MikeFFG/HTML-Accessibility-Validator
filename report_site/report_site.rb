require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'json'
require 'pry'

ACCESS_VAL_LOC = '/report_site/data/accessibility_validation_sample.json'.freeze
HTML_VAL_LOC = '/report_site/data/html_validation_sample.json'.freeze
ACCESS_VAL_LOC2 = '/logs/accessibility_data.json'.freeze
HTML_VAL_LOC2 = '/logs/html_data.json'.freeze

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, escape_html: true
  set port: 7655
end

helpers do
  def get_single_site_access_violations(index)
    access_vals = session[:access_vals_all][index]
    return if access_vals.nil?

    access_vals['rule_results'].select do |site|
      site['elements_violation'] > 0
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

  def site_tabs
    session[:html_vals_all].map do |site|
      site['url']
    end
  end
end

before do
  session[:index] ||= 0
  session[:access_vals_all] = read_access_data_from_logs
  session[:html_vals_all] = read_html_data_from_logs
  session[:site_tabs] = site_tabs
end

get '/' do
  redirect '/0'
end

get '/:id' do
  @index = params[:id].to_i
  @site_tabs = session[:site_tabs] # temp
  @access_val = get_single_site_access_violations(@index)
  @html_val = get_single_site_html_violations(@index)

  erb :table
end
