class ApplicationMailer < ActionMailer::Base
  default from: %("Thingybase" <website@thingybase.com>)
  layout 'mailer'
end
