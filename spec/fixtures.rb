
# testing fixtures
class Content < ActiveResource::Base
  self.site = ""
end
class Article < Content; end
class Page    < Content; end
class Comment < Content; end