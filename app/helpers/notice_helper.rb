module NoticeHelper
  def notice_message(message = nil, **html_options)
    if message ||= flash[:notice]
      render partial: "helpers/notice_helper/message", locals: {
        body: message,
        html_options: html_options
      }
    end
  end
end
