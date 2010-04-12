class Timestamper
  class Configuration
    attr_accessor :updated_at_column
    
    def initialize
      @updated_at_column = :updated_at
      @exclude = []
      @only = []
    end
    
    def exclude(*args)
      @exclude += args
    end
    
    def excluded_models
      @exclude.dup
    end
    
    def only(*args)
      @only += args
    end
    
    def only_models
      @only.dup
    end
    
    def reportable?(klass)
      return true if @exclude.empty? and @only.empty?
      
      if @only.empty?
        !@exclude.include?(klass)
      else
        (@only - @exclude).include?(klass)
      end 
    end
  end
end
