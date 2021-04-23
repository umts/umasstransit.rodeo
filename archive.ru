# frozen_string_literal: true

not_found = ->(_) { [404, { 'Content-Type' => 'text/plain' }, ['Not Found']] }
run Rack::Static.new(not_found, urls: [''], root: 'archive', index: 'index.html')
