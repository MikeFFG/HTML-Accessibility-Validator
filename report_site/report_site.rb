require 'sinatra'
require "sinatra/content_for"
require "sinatra/reloader"
require "tilt/erubis"
require 'json'

ACCESS_VAL_LOC = '/report_site/data/accessibility_validation_sample.json'
HTML_VAL_LOC = '/report_site/data/html_validation_sample.json'

configure do
  set :erb, :escape_html => true
end

get '/' do
  @site_tabs = ["title1", "title2", "title3"]
  @content = { "somekey" => "somevalue",
               "somekey1" => "somevalue1",
               "somekey2" => "somevalue2",
               "somekey3" => "somevalue3",
             }
  @html_val = JSON.parse(File.read(Dir.pwd + HTML_VAL_LOC))
  @access_val = JSON.parse(File.read(Dir.pwd + ACCESS_VAL_LOC))["page_eval_rule_results"].select do |result|
                  result['fields']['elements_violation'] > 0
                end

  erb :table
end
