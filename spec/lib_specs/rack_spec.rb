require 'spec_helper'
require 'rack/test'
require 'sinatra/base'
require 'timestamper/rack_middleware'
require 'active_resource/http_mock'

class MyApp < Sinatra::Base 
  use Timestamper::RackMiddleware 
  
  get "/" do
    "homepage"
  end
  
  get "/articles" do
    @article1 = Article.find 1
    'articles'
  end
end

describe Timestamper::RackMiddleware do
  include Rack::Test::Methods
  before(:each) do
    @today = Time.now
    @yesterday = 1.day.ago
    @tomorrow = 1.day.from_now
    Timestamper.instance.reset

    ActiveResource::HttpMock.respond_to do |mock|
      mock.get    "/articles/1.xml", {}, {:id => 1, :updated_at => @yesterday}.to_xml(:root => "article")
    end
  end
  
  def app
    my_app = MyApp.new
  end
  
  def log_response_body(str)
    File.open('response.html', 'w') do |f|
      f.write str
    end
  end
  
  it "should have default Last-Modified http header" do
    get "/"
    last_response.body.should == "homepage"
    last_response.headers["Last-Modified"].should_not be_nil
  end
  
  it "should set Last-Modified time from article" do
    get "/articles"
    last_response.body.should == "articles"
    last_response.headers["Last-Modified"].should == @yesterday.httpdate
  end
end
