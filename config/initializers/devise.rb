require 'devise/orm/active_record'

Devise.setup do |config|
  config.mailer_sender = 'transit-it@admin.umass.edu'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.pepper = '0761ef0892f647b6d3c525ee7d98043efadaae4b42d77102b56beba91bd44360d4cfb0ffa713778c281afe99e18c22ed0364330c28c0292fc25251c3f8858331'
  config.secret_key = '7dce324450fa7e8371325c63e65afb6c14fcde6f14ab5577d16d91d0a0f590e643219d31fbbe0e314d1888a0baa3aa3393a3d7870b4ff02a9e32cbcb2febe0fa'
  config.send_password_change_notification = true
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.email_regexp = /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
