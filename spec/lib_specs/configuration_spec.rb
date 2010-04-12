require 'spec_helper'

describe Timestamper::Configuration do
  before(:each) do
    @config = Timestamper::Configuration.new
  end
  
  describe "#exclude" do
    it "should exclude selected models" do
      @config.exclude Article, Page
      @config.excluded_models.should == [Article, Page]
    end    
  end
  
  describe "#only" do
    it "should only have selected models" do
      @config.only Article
      @config.only_models.should == [Article]
    end
  end
  
  describe "#reportable?" do
    it "should query whether model is reportable?" do
      @config.reportable?(Article).should be_true
      
      @config.only Article
      @config.reportable?(Article).should be_true
      @config.reportable?(Page).should be_false
  
      @config.exclude Article
      @config.reportable?(Article).should be_false
      @config.reportable?(Page).should be_false
      
      @config = Timestamper::Configuration.new
      @config.exclude Article
      @config.reportable?(Article).should be_false
      @config.reportable?(Page).should be_true
      
      @config.only Article
      @config.reportable?(Article).should be_false
      @config.reportable?(Page).should be_false
    end
  end
  
  describe "#updated_at_column" do
    it "should set updated_at_column" do
      @config.updated_at_column = :updated_at
      @config.updated_at_column.should == :updated_at
    end
  end
end
