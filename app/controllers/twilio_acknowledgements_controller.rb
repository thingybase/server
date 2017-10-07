class TwilioAcknowledgementsController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user
  skip_after_action :verify_authorized

  def create
    @acknowledgement = Acknowledgement.from_claim(params[:claim])
    response = Twilio::TwiML::VoiceResponse.new

    # TODO: Make this respond via TwiML
    respond_to do |format|
      if @acknowledgement.save
        response.say "You have successfully acknowledged this notification. Good bye."
        format.xml { render body: response, status: :created, location: @acknowledgement }
      else
        response.say "Something wrong happened with Pagerline."
        format.xml { render body: response, status: :unprocessable_entity }
      end
    end
  end
end
