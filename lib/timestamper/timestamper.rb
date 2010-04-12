
class Timestamper 
  include Singleton
  attr_accessor :updated_at, :override
  
  def reset
    @override = nil
    @updated_at = nil
  end
  
  def updated_at
    @override ? @override : @updated_at
  end
  
  def updated_at=(time)
    @updated_at = time if self.updated_at.nil? or time > self.updated_at
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  def self.config(&block)
    configuration.instance_eval(&block)
  end
end
