$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "adminable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "adminable"
  s.version     = Adminable::VERSION
  s.authors     = ["Vsevolod"]
  s.email       = ["gsevka@gmail.com"]
  s.homepage    = "http://github.com/vsevolod"
  s.summary     = "Simple admin with default structure"
  s.description = "Contain models: Dictionary, Page, Category, Item, Banner, Gallery with GalleryObject"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"
  s.add_dependency 'draper'
  s.add_dependency 'ancestry'
  s.add_dependency 'paperclip'
  s.add_dependency 'paperclip-ffmpeg'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'pg'
  #s.add_dependency 'activeadmin'
  #s.add_dependency 'active_admin-sortable_tree'
  #s.add_dependency 'activeadmin-dragonfly', github: 'stefanoverna/activeadmin-dragonfly'
  #s.add_dependency 'activeadmin-wysihtml5', github: 'stefanoverna/activeadmin-wysihtml5'

  s.add_development_dependency 'pry'
end
