# frozen_string_literal: true

server 'umasstransit.rodeo', roles: %w[app db web]

set :default_env, { 'SECRET_KEY_BASE' => 'NOT_A_REAL_SECRET_AND_THATS_OK' }
