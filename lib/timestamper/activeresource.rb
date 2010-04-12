module ActiveResource
  class Base
    class << self
      def timestamper_column(column)
        @timestamper_column = column
      end
      
      private 
      def new_with_timestamper(*args)
        returning new_without_timestamper(*args) do |record|
          next if !Timestamper.configuration.reportable?(record.class)  # return triggers "LocalJumpError: unexpected return"
          
          column = @timestamper_column || Timestamper.configuration.updated_at_column
          Timestamper.instance.updated_at = record.send(column) if record.respond_to?(column)
        end
      end
      
      alias_method_chain :new, :timestamper
    end
  end
end
