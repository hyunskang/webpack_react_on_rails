$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "webpack_react_on_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "webpack_react_on_rails"
  s.version     = WebpackReactOnRails::VERSION
  s.authors     = ["Hyun Sik Kang"]
  s.email       = ["hyunsikk91@gmail.com"]
  s.homepage    = "https://github.com/brokenfingers/webpack-react-on-rails"
  s.summary     = "Scaffolder for React, Redux, and Webpack"
  s.description = "Easily add React, Redux, and Webpack using a command line."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.required_ruby_version = '>= 2.1.0'

  # Dev dependencies
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry-rails'

  # Gem dependencies
  s.add_dependency 'rails', '>= 4.1.0', '< 5.1'

end
