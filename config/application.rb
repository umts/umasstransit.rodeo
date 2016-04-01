require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)
 
module UmasstransitRodeo
  class Application < Rails::Application
    config.encoding = 'utf-8'
    config.time_zone = 'Eastern Time (US & Canada)'
    config.autoload_paths << Rails.root.join('lib')
    config.filter_parameters += [:password, :secret, :spire, :github]
    config.assets.paths << "#{Rails}/vendor/assets/fonts"
    config.active_record.raise_in_transactional_callbacks = true
  end
end
