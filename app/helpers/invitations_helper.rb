module InvitationsHelper
  def render_email_body(mailer)
    raw Nokogiri::HTML(mailer.body.to_s).css("body").inner_html
  end
end
