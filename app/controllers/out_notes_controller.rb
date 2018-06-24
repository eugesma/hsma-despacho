class OutNotesController < ApplicationController
  before_action :set_out_note, only: [:show, :edit, :update, :destroy]

  # GET /out_notes
  # GET /out_notes.json
  def index
    @out_notes = OutNote.paginate(:page => params[:page], :per_page => 8)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /out_notes/1
  # GET /out_notes/1.json
  def show
    respond_to do |format|
      format.js
    end
  end

  # GET /out_notes/new
  def new
    @out_note = OutNote.new
    @sectors = Sector.all
  end

  # GET /out_notes/1/edit
  def edit
  end

  # POST /out_notes
  # POST /out_notes.json
  def create
    @out_note = OutNote.new(out_note_params)
    @out_note.author = current_user

    respond_to do |format|
      if @out_note.save!
        flash.now[:success] = "La nota saliente número "+@out_note.note_number.to_s+" se ha creado correctamente."
        format.js
      else
        flash.now[:error] = "La nota saliente no se ha podido crear."
        format.js
      end
    end
  end

  # PATCH/PUT /out_notes/1
  # PATCH/PUT /out_notes/1.json
  def update
    respond_to do |format|
      if @out_note.update_attributes(out_note_params)
        flash.now[:success] = "La nota saliente número "+@out_note.note_number.to_s+" se ha modificado correctamente."
        format.js
      else
        flash.now[:error] = "La nota saliente número "+@out_note.note_number.to_s+" no se ha podido modificar."
        format.js
      end
    end
  end

  # DELETE /out_notes/1
  # DELETE /out_notes/1.json
  def destroy
    @number = @out_note.note_number
    @out_note.destroy
    respond_to do |format|
      flash.now[:success] = "La nota saliente número "+@number.to_s+" se ha eliminado correctamente."
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_out_note
      @out_note = OutNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def out_note_params
      params.require(:out_note).permit(:note_number, :destination_id, :origin_id, :reference, :zonal_pass, :subse_number, :entry_date, :out_date, :image)
    end
end
