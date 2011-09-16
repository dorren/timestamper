
# testing fixtures
class Content < ActiveResource::Base
  self.site = "http://example.org"
end
class Article < Content; end
class Page    < Content; end
class Comment < Content; end