class ApplicationMailer < ActionMailer::Base
  default from: %("Thingybase" <website@thingybase.com>)
  layout 'mailer'

  private
    def mailer(component, **)
      mail(**) do |format|
        format.html { render component }
        format.text
      end
    end
end
