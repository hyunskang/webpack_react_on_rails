$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "webpack_react_on_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "webpack-react-on-rails"
  s.version     = WebpackReactOnRails::VERSION
  s.authors     = ["Hyun Sik Kang"]
  s.email       = ["hyunsikk91@gmail.com"]
  s.homepage    = "https://github.com/brokenfingers/webpack-react-on-rails/tree/master/lib"
  s.summary     = "Scaffolder for React, Redux, and Webpack"
  s.description = "Easily add React, Redux, and Webpack using a command line."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5"
end
