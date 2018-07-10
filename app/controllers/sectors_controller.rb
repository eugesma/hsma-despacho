class SectorsController < ApplicationController
  before_action :set_sector, only: [:show, :edit, :update, :destroy, :delete]

  # GET /sectors
  # GET /sectors.json
  def index
    @sectors = Sector.all
    @sectors = Sector.paginate(:page => params[:page], :per_page => 8)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /sectors/1
  # GET /sectors/1.json
  def show
    authorize @sector
    respond_to do |format|
      format.js
    end
  end

  # GET /sectors/new
  def new
    authorize Sector
    @sector = Sector.new
  end

  # GET /sectors/1/edit
  def edit
    authorize @sector
  end

  # POST /sectors
  # POST /sectors.json
  def create
    @sector = Sector.new(sector_params)
    authorize @sector

    respond_to do |format|
      if @sector.save!
        flash.now[:success] = "El sector "+@sector.sector_name+" se ha creado correctamente."
        format.js
      else
        flash.now[:error] = "El sector "+@sector.sector_name+"no se ha podido crear."
        format.js
      end
    end
  end

  # PATCH/PUT /sectors/1
  # PATCH/PUT /sectors/1.json
  def update
    authorize @sector

    respond_to do |format|
      if @sector.update_attributes(sector_params)
        flash.now[:success] = "El sector "+@sector.sector_name+" se ha modificado correctamente."
        format.js
      else
        flash.now[:error] = "El sector "+@sector.sector_name+" no se ha podido modificar."
        format.js
      end
    end
  end

  # DELETE /sectors/1
  # DELETE /sectors/1.json
  def destroy
    authorize @sector
    @sector_name = @sector.sector_name
    @sector.destroy
    respond_to do |format|
      flash.now[:success] = "La nota entrante número "+@sector_name+" se ha eliminado correctamente."
      format.js
    end
  end

  # GET /sector/1/delete
  def delete
    authorize @sector

    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sector
      @sector = Sector.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sector_params
      params.require(:sector).permit(:sector_name, :description, :professional_id, :entry_note_id)
    end
end
