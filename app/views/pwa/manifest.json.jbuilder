# frozen_string_literal: true

Rails.configuration.roadeo.tap do |config|
  json.name "#{config.organization} - #{config.event_name}"
  json.short_name 'Roadeo app'
  json.background_color config.background
  json.theme_color config.background
end

json.start_url '/'
json.display 'standalone'
json.scope '/'

json.icons do
  json.child! do
    json.src asset_path('icon-192.png')
    json.sizes '192x192'
    json.type 'image/png'
  end
  json.child! do
    json.src asset_path('icon-512.png')
    json.sizes '512x512'
    json.type 'image/png'
  end
  json.child! do
    json.src asset_path('icon-mask.png')
    json.sizes '512x512'
    json.type 'image/png'
    json.purpose 'maskable'
  end
end
