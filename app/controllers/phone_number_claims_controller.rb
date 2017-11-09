class PhoneNumberClaimsController < ApplicationController
  before_action :authenticate_user
  before_action :set_phone_number_claim, only: [:show, :edit, :update, :destroy]
  before_action :authorize_phone_number_claim, only: [:show, :edit, :destroy]

  # GET /phone_number_claims
  # GET /phone_number_claims.json
  def index
    @phone_number_claims = policy_scope(PhoneNumberClaim)
  end

  # GET /phone_number_claims/1
  # GET /phone_number_claims/1.json
  def show
  end

  # GET /phone_number_claims/new
  def new
    @phone_number_claim = PhoneNumberClaim.new
    @phone_number_claim.user = current_user
    authorize_phone_number_claim
  end

  # GET /phone_number_claims/1/edit
  def edit
    @phone_number_claim.code = nil
  end

  # POST /phone_number_claims
  # POST /phone_number_claims.json
  def create
    @phone_number_claim = PhoneNumberClaim.new(phone_number_claim_params)
    @phone_number_claim.user = current_user
    authorize_phone_number_claim

    respond_to do |format|
      if @phone_number_claim.save
        # TODO: Verify this happens via mock.
        SendClaimCodeSmsJob.perform_later @phone_number_claim
        format.html { redirect_to [:edit, @phone_number_claim.verification], notice: 'Phone number claim was successfully created.' }
        format.json { render :show, status: :created, location: @phone_number_claim }
      else
        format.html { render :new }
        format.json { render json: @phone_number_claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phone_number_claims/1
  # PATCH/PUT /phone_number_claims/1.json
  def update
    @phone_number_claim.assign_attributes(phone_number_claim_params)
    authorize_phone_number_claim

    respond_to do |format|
      if @phone_number_claim.save
        format.html { redirect_to @phone_number_claim, notice: 'Phone number claim was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone_number_claim }
      else
        format.html { render :edit }
        format.json { render json: @phone_number_claim.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phone_number_claims/1
  # DELETE /phone_number_claims/1.json
  def destroy
    @phone_number_claim.destroy
    respond_to do |format|
      format.html { redirect_to phone_number_claims_url, notice: 'Phone number claim was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def authorize_phone_number_claim
      authorize @phone_number_claim
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_phone_number_claim
      @phone_number_claim = PhoneNumberClaim.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def phone_number_claim_params
      params.require(:phone_number_claim).permit(:phone_number)
    end
end
