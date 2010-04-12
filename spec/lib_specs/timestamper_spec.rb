

describe Timestamper do
  before do
    @today = Time.now
    @yesterday = 1.day.ago
    @tomorrow = 1.day.from_now
    Timestamper.instance.reset
  end
  
  describe "#instance" do
    it "should implement singleton pattern" do
      proc {Timestamper.new}.should raise_error
      proc {Timestamper.instance}.should_not raise_error
    end
  end

  describe "#reset" do
    it "should reset itself" do
      Timestamper.instance.updated_at = @today
      Timestamper.instance.override = @yesterday
      Timestamper.instance.reset
      Timestamper.instance.updated_at.should be_nil
      Timestamper.instance.override.should be_nil
    end
  end

  describe "#update_at" do
    it "should be able to set updated_at time" do
      Timestamper.instance.updated_at.should be_nil
      Timestamper.instance.updated_at = @today
      Timestamper.instance.updated_at.should == @today    
    end
  
    it "should only change updated_at time if the new value is the latest time" do
      Timestamper.instance.updated_at = @tomorrow
      Timestamper.instance.updated_at = @today
      Timestamper.instance.updated_at.should == @tomorrow
    end
  end
  
  describe "#override" do
    it "should override current updated_at value when updated_at is nil" do
      Timestamper.instance.updated_at.should be_nil
      Timestamper.instance.override = @today
      Timestamper.instance.updated_at.should == @today
    end
    
    it "should override current updated_at value" do
      Timestamper.instance.updated_at = @tomorrow
      Timestamper.instance.override = @today
      Timestamper.instance.updated_at.should == @today
      
      Timestamper.instance.updated_at = @today + 2.days
      Timestamper.instance.updated_at.should == @today
    end
  end
  
  describe "##configuration" do
    it "should return an instance of Timestamper::Configuration" do
      Timestamper.configuration.class.should == Timestamper::Configuration
    end
  end
  
  
  
  describe "##config" do
    it "should accept a block" do
      proc {Timestamper.config {}}.should_not raise_error
    end
    
    it "should evaluate the block within the Timestamper.configuration instance" do
      Timestamper.config do
        self.should == Timestamper.configuration
      end
    end
  end
end
