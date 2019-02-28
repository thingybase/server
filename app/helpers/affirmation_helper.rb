module AffirmationHelper
  def affirm(message)
    flash[:affirmation_message] = message
  end

  def affirmation_message
    if message = flash[:affirmation_message]
      render partial: "helpers/affirmation_helper/message", locals: { body: message }
    end
  end
end
