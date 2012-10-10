$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "graffity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "graffity"
  s.version     = Graffity::VERSION
  s.authors     = ["Peter Berkenbosch"]
  s.email       = ["peter@pero-ict.nl"]
  s.homepage    = "https://github.com/pero-ict-solutions/graffity"
  s.summary     = "Development tool to render a view stack"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.8"
  s.add_dependency "sequel"
  s.add_dependency "coderay"
  s.add_dependency "deface"
  s.add_dependency "sqlite3"
end
