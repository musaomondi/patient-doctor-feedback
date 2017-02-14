class PatientsController < ApplicationController
  # before_filter :authenticate
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  # GET /patients.json
  def index
    @patients = Patient.paginate(:page => params[:page])
  end

  # GET /patients/1
  # GET /patients/1.json
  def show
    @user_patients = @patient.user_patients.reverse.paginate(:page => params[:page], :per_page => 5)
    @enableInvoice = @patient.user_patients.where("archive is null").size
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to @patient, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to @patient, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def search
  end

  def searchPatients
    search_by_first_name = params[:patient][:first_name]
    search_by_last_name = params[:patient][:last_name]
    search_by_id = params[:patient][:patient_id]
    search_by_email_id = params[:patient][:email_id]
    sql = String.new

    if !search_by_id.blank?
      sql = "id = " + search_by_id
    end
    if !search_by_email_id.blank?
      if sql.blank?
        sql += "email_id like '%"+ search_by_email_id + "%'"
      else
        sql += " or email_id like '%"+ search_by_email_id + "%'"
      end
    end
    if !search_by_first_name.blank?
      if sql.blank?
        sql += "first_name like '%"+ search_by_first_name + "%'"
      else
        sql += " or first_name like '%"+ search_by_first_name + "%'"
      end
    end

    if !search_by_last_name.blank?
      if sql.blank?
        sql += "last_name like '%"+ search_by_last_name + "%'"
      else
        sql += " or last_name like '%"+ search_by_last_name + "%'"
      end
    end

    if !sql.blank?
      @patients = Patient.where(sql).paginate(:page => params[:page], :per_page => 5)
    end
  end

  def generate_invoice
    @patient = Patient.find(params[:id])
    @user_patients  = @patient.user_patients.where("archive is null")
    respond_to do |format|
      format.html
      format.pdf do
        pdf = HmsPdfDocument.new(SessionsHelper::FOR_PATIENT, @user_patients, view_context)
        @user_patients.update_all :archive => SessionsHelper::ARCHIVE
        send_data pdf.render, filename: "invoice_summary_#{@patient.id}.pdf", type: "application/pdf"
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :age, :gender, :county, :town, :status, :phone_number)
    end
end
