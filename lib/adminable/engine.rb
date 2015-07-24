module Adminable
  class Engine < ::Rails::Engine
    config.autoload_paths += %W(#{config.root}/lib)
    config.i18n.default_locale = :ru
    config.active_record.raise_in_transactional_callbacks = true
    isolate_namespace Adminable
    initializer :my_engine do
      ActiveAdmin.application.load_paths += %W(#{config.root}/app/admin)
    end
  end
end
