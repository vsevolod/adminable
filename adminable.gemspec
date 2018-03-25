lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# Maintain your gem's version:
require "adminable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "adminable"
  s.version     = Adminable::VERSION
  s.authors     = ["Vsevolod"]
  s.email       = ["gsevka@gmail.com"]
  s.homepage    = "http://github.com/vsevolod"
  s.summary     = "Simple CMS with dynamic fields structure"
  s.description = "Contain models: Dictionary, Page, Category, Item, Banner, Gallery with GalleryObject"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'draper'
  s.add_dependency 'ancestry'
  s.add_dependency 'paperclip'
  s.add_dependency 'paperclip-ffmpeg'
  s.add_dependency 'delayed_paperclip'
  s.add_dependency 'acts_as_list'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'pg'
  s.add_dependency 'resque'
  s.add_dependency 'haml'
  s.add_dependency 'uglifier', '>= 1.3.0'
  s.add_dependency 'jbuilder', '~> 2.0'
  s.add_dependency 'russian'
  s.add_dependency 'breadcrumbs_on_rails'
  s.add_dependency 'simple_form'

  s.add_dependency 'activeadmin', '~> 1.2.1'
  s.add_dependency 'active_admin-sortable_tree'
end
