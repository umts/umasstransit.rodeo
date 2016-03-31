require 'devise/orm/active_record'

Devise.setup do |config|
  config.mailer_sender = 'transit-it@admin.umass.edu'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.pepper = '0761ef0892f647b6d3c525ee7d98043efadaae4b42d77102b56beba91bd44360d4cfb0ffa713778c281afe99e18c22ed0364330c28c0292fc25251c3f8858331'
  config.send_password_change_notification = true
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
