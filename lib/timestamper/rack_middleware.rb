class Timestamper
  class RackMiddleware
    def initialize(app)
      @app = app
    end
  
    def call(env)
      Timestamper.instance.reset
      status, headers, response = @app.call(env)
      if headers["Content-Type"].to_s =~ /^text\/html/

        if headers['Last-Modified'].nil?
          timestamp = Timestamper.instance.updated_at || Time.now
          headers['Last-Modified'] = timestamp.httpdate
        end
        # rails return response object with body method, sinatra just returns array of 1 string
        response = response.respond_to?(:body) ? response.body : response
        [status, headers, response]
      else
        [status, headers, response]
      end
    end
  end
end
