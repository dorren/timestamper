Gem::Specification.new do |s|
  s.name           = "timestamper"
  s.version        = File.read "VERSION"
  s.description    = "This gem sets Last-Modified in http response header with timestamp extracted from ActiveResource."
  s.summary        = "Last-Modified and ActiveResource combined!"
  s.homepage       = "http://github.com/dorren/timestamper"
  s.author         = "Dorren Chen"
  s.email          = "dorrenchen@gmail.com"

  s.files          = Dir["lib/**/*"] << "VERSION" << "timestamper.gemspec" << "README.rdoc"
  s.test_files     = Dir["spec/**/*"]

  s.add_dependency              "activeresource", "~> 3.0.0"
  s.add_development_dependency  "rack-test"
  s.add_development_dependency  "rspec"
  s.add_development_dependency  "sinatra"
end
  
