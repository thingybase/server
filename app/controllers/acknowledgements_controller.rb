class AcknowledgementsController < ApplicationController
  before_action :authenticate_user
  # TODO: Authorize notification
  before_action :set_notification, only: [:new]
  before_action :set_acknowledgement, only: [:show, :edit, :update, :destroy]
  before_action :authorize_acknowledgement, only: [:show, :edit, :destroy]

  # GET /acknowledgements
  # GET /acknowledgements.json
  def index
    @acknowledgements = policy_scope(Acknowledgement).joins(:user, :notification)
  end

  # GET /acknowledgements/1
  # GET /acknowledgements/1.json
  def show
  end

  # GET /acknowledgements/new
  def new
    @acknowledgement = Acknowledgement.new
    @acknowledgement.notification = @notification
    @acknowledgement.user = current_user
    authorize_acknowledgement
  end

  # GET /acknowledgements/1/edit
  def edit
  end

  # POST /acknowledgements
  # POST /acknowledgements.json
  def create
    @acknowledgement = Acknowledgement.new(acknowledgement_params)
    @acknowledgement.user = current_user
    authorize_acknowledgement

    respond_to do |format|
      if @acknowledgement.save
        format.html { redirect_to @acknowledgement, notice: 'Acknowledgement was successfully created.' }
        format.json { render :show, status: :created, location: @acknowledgement }
      else
        format.html { render :new }
        format.json { render json: @acknowledgement.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /acknowledgements
  # POST /acknowledgements.json
  def claim
    @acknowledgement = Acknowledgement.from_claim(params[:claim])

    # TODO: These should reply with a TwiML response ...
    respond_to do |format|
      if @acknowledgement.save
        format.html { redirect_to @acknowledgement, notice: 'Acknowledgement was successfully created.' }
        format.json { render :show, status: :created, location: @acknowledgement }
      else
        format.html { render :new }
        format.json { render json: @acknowledgement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acknowledgements/1
  # PATCH/PUT /acknowledgements/1.json
  def update
    @acknowledgement.assign_attributes(acknowledgement_params)
    @acknowledgement.user = current_user
    authorize_acknowledgement

    respond_to do |format|
      if @acknowledgement.save
        format.html { redirect_to @acknowledgement, notice: 'Acknowledgement was successfully updated.' }
        format.json { render :show, status: :ok, location: @acknowledgement }
      else
        format.html { render :edit }
        format.json { render json: @acknowledgement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acknowledgements/1
  # DELETE /acknowledgements/1.json
  def destroy
    @acknowledgement.destroy
    respond_to do |format|
      format.html { redirect_to acknowledgements_url, notice: 'Acknowledgement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acknowledgement
      @acknowledgement = Acknowledgement.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_notification
      @notification = Notification.find(params[:notification_id]) if params.key?(:notification_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acknowledgement_params
      params.require(:acknowledgement).permit(:notification_id)
    end

    def authorize_acknowledgement
      authorize @acknowledgement
    end
end
