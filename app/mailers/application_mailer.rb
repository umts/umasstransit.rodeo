class ApplicationMailer < ActionMailer::Base
  default from: 'transit-it@admin.umass.edu'
  layout 'mailer'
end