class InternalNotesController < ApplicationController
  before_action :set_internal_note, only: [:show, :edit, :update, :destroy, :delete, :show_image]

  # GET /internal_notes
  # GET /internal_notes.json
  def index
    @filterrific = initialize_filterrific(
      InternalNote,
      params[:filterrific],
      select_options: {
      },
    ) or return
    @internal_notes = @filterrific.find.page(params[:page]).per_page(10)
  end

  # GET /internal_notes/1
  # GET /internal_notes/1.json
  def show
    authorize @internal_note
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /internal_notes/new
  def new
    authorize InternalNote
    @internal_note = InternalNote.new
    @sectors = Sector.all
    @order_type = 'nota'
  end

  # GET /internal_notes/new_pass
  def new_pass
    authorize InternalNote
    @internal_note = InternalNote.new
    @sectors = Sector.all
    @order_type = 'pase'
  end  

  # GET /internal_notes/1/edit
  def edit
    authorize @internal_note
    @sectors = Sector.all
  end

  # GET /internal_notes/1/edit_pass
  def edit_pass
    authorize @internal_note
    @sectors = Sector.all
  end

  # POST /internal_notes
  # POST /internal_notes.json
  def create
    @internal_note = InternalNote.new(internal_note_params)
    @internal_note.author = current_user
    authorize @internal_note

    respond_to do |format|
      if @internal_note.save
        flash[:success] = 'La nota se ha cargado correctamente'
        format.html { redirect_to @internal_note }
      else
        @sectors = Sector.all
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /internal_notes/1
  # PATCH/PUT /internal_notes/1.json
  def update
    authorize @internal_note
    respond_to do |format|
      if @internal_note.update(internal_note_params)
        flash[:success] = 'La nota se ha modificado correctamente'
        format.html { redirect_to @internal_note }
      else
        @sectors = Sector.all
        flash[:error] = "La nota no se ha podido modificar."
        format.html { render :edit }
      end
    end
  end

  # DELETE /internal_notes/1
  # DELETE /internal_notes/1.json
  def destroy
    authorize @internal_note
    @number = @internal_note.note_number
    @order_type = @internal_note.order_type
    @internal_note.destroy
    respond_to do |format|
      flash[:success] = @order_type.humanize+" saliente número "+@number.to_s+" se ha eliminado correctamente."
      format.html { redirect_to action: "index" } 
    end
  end

  # GET /internal_note/1/delete
  def delete
    authorize @internal_note
  end

  # GET /internal_notes/1
  def show_image
    respond_to do |format|
      format.js
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_note
    @internal_note = InternalNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def internal_note_params
    params.require(:internal_note).permit(:note_number, :destination_id, :origin_id,
                                        :reference, :zonal_pass, :order_type,
                                        :entry_date, :out_date, files:[])
    end
end
