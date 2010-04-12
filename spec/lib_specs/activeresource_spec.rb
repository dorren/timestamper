require 'spec_helper'

describe ActiveResource::Base do
  before do
    @today = Time.now
    @yesterday = 1.day.ago
    @tomorrow = 1.day.from_now
    Timestamper.instance.reset
  end
  
  describe "#new" do
    it "should report updated_at time" do
      Timestamper.instance.updated_at.should be_nil
      Article.new :updated_at => @today
      Timestamper.instance.updated_at.should == @today
    end
  end

  describe "#new_with_timestamper" do
    it "should not set time if class is not reportable" do
      class Draft < Content; end
      
      Timestamper.instance.updated_at.should be_nil
      Timestamper.configuration.exclude Draft
      Draft.new :updated_at => @today
      Timestamper.instance.updated_at.should be_nil
    end
  end

  describe "##timestamper_column" do
    class MyArticle < Content; end
    it "should set timestamper_column" do
      MyArticle.class_eval do
        timestamper_column :last_modified
      end
      Timestamper.instance.updated_at.should be_nil
      MyArticle.new :last_modified => @today
      Timestamper.instance.updated_at.should == @today
    end
  end
  
end
