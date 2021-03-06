Gem.loaded_specs['adminable'].dependencies.each do |d|
  case d.name
  when 'active_admin-sortable_tree'
    require 'active_admin/sortable_tree'
  else
    require d.name
  end
end

module Adminable
  class Engine < ::Rails::Engine
    engine_name 'admin'
    config.autoload_paths += %W(#{config.root}/lib)
    config.i18n.default_locale = :ru
    config.active_record.raise_in_transactional_callbacks = true
    config.active_job.queue_adapter = :resque
    #isolate_namespace Adminable
    initializer :my_engine do
      #ActiveAdmin.application.load_paths += %W(#{config.root}/app/admin)
      ActiveAdmin.application.load_paths += %W(#{config.root}/lib/adminable/admin)
    end
  end
end
