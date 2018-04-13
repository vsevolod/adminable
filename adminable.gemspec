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
  s.add_dependency 'aws-sdk', '~> 2.3.0'
  s.add_dependency 'paperclip-ffmpeg'
  s.add_dependency 'delayed_paperclip'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'pg'
  s.add_dependency 'resque'
  s.add_dependency 'haml'
  s.add_dependency 'less-rails', '~> 2.7.0'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'uglifier', '>= 1.3.0'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'turbolinks'
  s.add_dependency 'jbuilder', '~> 2.0'
  s.add_dependency 'therubyracer'
  s.add_dependency 'russian'
  s.add_dependency 'breadcrumbs_on_rails'
  s.add_dependency 'simple_form'

  #s.add_dependency 'activeadmin'
  s.add_dependency 'active_admin-sortable_tree'
  #s.add_dependency 'activeadmin-dragonfly', github: 'stefanoverna/activeadmin-dragonfly'
  #s.add_dependency 'activeadmin-wysihtml5', github: 'stefanoverna/activeadmin-wysihtml5'

  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'letter_opener'
end
