class SectorsController < ApplicationController
  before_action :set_sector, only: [:show, :edit, :update, :destroy, :delete]

  # GET /sectors
  # GET /sectors.json
  def index
    authorize Sector
    @filterrific = initialize_filterrific(
      Sector,
      params[:filterrific],
      select_options: {
        sorted_by: Sector.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {sorted_by: 'fecha_creado_desc'},
      available_filters: [
        :sorted_by,
        :search_name,
        :created_at,
        :updated_at,
      ],
    ) or return
    @sectors = @filterrific.find.page(params[:page]).per_page(10)

    respond_to do |format|
      format.html
      format.js
    end
    rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
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
        flash.now[:success] = "El sector "+@sector.name+" se ha creado correctamente."
        format.js
      else
        flash.now[:error] = "El sector "+@sector.name+"no se ha podido crear."
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
        flash.now[:success] = "El sector "+@sector.name+" se ha modificado correctamente."
        format.js
      else
        flash.now[:error] = "El sector "+@sector.name+" no se ha podido modificar."
        format.js
      end
    end
  end

  # DELETE /sectors/1
  # DELETE /sectors/1.json
  def destroy
    authorize @sector
    @name = @sector.name
    @sector.destroy
    respond_to do |format|
      flash.now[:success] = "La nota entrante número "+@name+" se ha eliminado correctamente."
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
      params.require(:sector).permit(:name, :professional_id, :entry_note_id)
    end
end
