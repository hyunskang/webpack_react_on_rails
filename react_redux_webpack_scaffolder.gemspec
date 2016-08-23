$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "react_redux_webpack_scaffolder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "react_redux_webpack_scaffolder"
  s.version     = ReactReduxWebpackScaffolder::VERSION
  s.authors     = ["Hyun Sik Kang"]
  s.email       = ["hyunsikk91@gmail.com"]
  s.homepage    = "https://github.com/brokenfingers/react_redux_webpack_scaffolder/tree/master/lib"
  s.summary     = "Scaffolder for React, Redux, and Webpack"
  s.description = "Easily add React, Redux, and Webpack using a command line."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.7.1"

  s.add_development_dependency "sqlite3"
end
