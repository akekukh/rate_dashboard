class Admin::RatesController < ApplicationController
  before_action :set_admin_rate, only: [:show, :edit, :update, :destroy]

  # GET /admin/rates
  # GET /admin/rates.json
  def index
    @admin_rates = Admin::Rate.all
  end

  # GET /admin/rates/1
  # GET /admin/rates/1.json
  def show; end

  # GET /admin/rates/new
  def new
    @admin_rate = Admin::Rate.last.dup || Admin::Rate.new
  end

  # GET /admin/rates/1/edit
  def edit; end

  # POST /admin/rates
  # POST /admin/rates.json
  def create
    @admin_rate = Admin::Rate.new(admin_rate_params)
    respond_to do |format|
      if @admin_rate.save
        format.html { redirect_to admin_root_url, notice: 'Rate was successfully created.' }
        format.json { render :show, status: :created, location: admin_root_url }
      else
        format.html { render :new }
        format.json { render json: admin_root_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/rates/1
  # PATCH/PUT /admin/rates/1.json
  def update
    respond_to do |format|
      if @admin_rate.update(admin_rate_params)
        format.html { redirect_to @admin_rate, notice: 'Rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_rate }
      else
        format.html { render :edit }
        format.json { render json: @admin_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/rates/1
  # DELETE /admin/rates/1.json
  def destroy
    @admin_rate.destroy
    respond_to do |format|
      format.html { redirect_to admin_rates_url, notice: 'Rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_rate
    @admin_rate = Admin::Rate.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_rate_params
    params.require(:admin_rate).permit(:rate, :finished_at)
  end
end
