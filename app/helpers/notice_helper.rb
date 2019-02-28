module NoticeHelper
  def notice_message
    if message = flash[:notice]
      render partial: "helpers/notice_helper/message", locals: { body: message }
    end
  end
end
