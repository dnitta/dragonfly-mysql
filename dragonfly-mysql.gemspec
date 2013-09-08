$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "dragonfly_mysql/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "dragonfly-mysql"
  s.version     = DragonflyMysql::VERSION
  s.authors     = ["Daisuke Nitta"]
  s.email       = ["dnitta@email.com"]
  s.homepage    = ""
  s.summary     = "Summary of DragonflyMysql."
  s.description = "Description of DragonflyMysql."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "dragonfly"
  s.add_dependency "mysql2"
end
