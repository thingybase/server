class PhoneNumberVerificationsController < ApplicationController
  before_action :authenticate_user
  before_action :set_phone_number_verification, only: [:show, :edit, :update, :destroy]
  before_action :authorize_phone_number_verification, except: :update

  # GET /phone_number_verifications/1/edit
  def edit
  end

  # PATCH/PUT /phone_number_verifications/1
  # PATCH/PUT /phone_number_verifications/1.json
  def update
    @phone_number_verification.assign_attributes(phone_number_verification_params)
    authorize_phone_number_verification

    respond_to do |format|
      if @phone_number_verification.save
        format.html { redirect_to @phone_number_verification.user, notice: 'Phone number verification was successfully updated.' }
        format.json { head status: :created, location: @phone_number_verification.user }
      else
        format.html { render :edit }
        format.json { render json: @phone_number_verification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_number_verifications/1
  # DELETE /phone_number_verifications/1.json
  def destroy
    @phone_number_verification.destroy
    respond_to do |format|
      format.html { redirect_to phone_number_verifications_url, notice: 'Phone number verification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phone_number_verification
      @phone_number_verification = PhoneNumberVerification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_number_verification_params
      params.require(:phone_number_verification).permit(:code)
    end

    def authorize_phone_number_verification
      authorize @phone_number_verification
    end
end
