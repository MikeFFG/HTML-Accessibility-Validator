require 'sinatra'
require "sinatra/content_for"
require "sinatra/reloader"
require "tilt/erubis"

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

  erb :table
end
