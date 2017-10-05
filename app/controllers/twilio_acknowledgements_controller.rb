class TwilioAcknowledgementsController < ApplicationController
  def create
    @acknowledgement = Acknowledgement.from_claim(params[:claim])

    # TODO: Make this respond via TwiML
    respond_to do |format|
      if @acknowledgement.save
        format.json { render :show, status: :created, location: @acknowledgement }
      else
        format.json { render json: @acknowledgement.errors, status: :unprocessable_entity }
      end
    end
  end
end
