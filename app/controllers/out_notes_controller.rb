class OutNotesController < ApplicationController
  before_action :set_out_note, only: [:show, :edit, :update, :destroy, :delete, :show_image]

  # GET /out_notes
  # GET /out_notes.json
  def index
    @filterrific = initialize_filterrific(
      OutNote,
      params[:filterrific],
      select_options: {
        sorted_by: EntryNote.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {sorted_by: 'created_at_desc'},
      available_filters: [
        :sorted_by,
        :search_text,
        :entry_date_at,
        :out_date_at,
        :with_note_number,
      ],
    ) or return
    @out_notes = @filterrific.find.page(params[:page]).per_page(10)
    respond_to do |format|
      format.html
      format.js
    end
    rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /out_notes/1
  # GET /out_notes/1.json
  def show
    authorize @out_note
    respond_to do |format|
      format.js
    end
  end

  # GET /out_notes/new
  def new
    authorize OutNote
    @out_note = OutNote.new
    @sectors = Sector.all
  end

  # GET /out_notes/1/edit
  def edit
    authorize @out_note
    @sectors = Sector.all
  end

  # POST /out_notes
  # POST /out_notes.json
  def create
    @out_note = OutNote.new(out_note_params)
    @out_note.author = current_user
    authorize @out_note

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
    authorize @out_note

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
    authorize @out_note
    @number = @out_note.note_number
    @out_note.destroy
    respond_to do |format|
      flash.now[:success] = "La nota saliente número "+@number.to_s+" se ha eliminado correctamente."
      format.js
    end
  end

  # GET /out_note/1/delete
  def delete
    authorize @out_note

    respond_to do |format|
      format.js
    end
  end

  # GET /out_notes/1
  def show_image
    respond_to do |format|
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
      params.require(:out_note).permit(:note_number, :destination_id, :origin_id,
                                       :reference, :zonal_pass, :subse_number,
                                       :entry_date, :out_date, files:[])
    end
end
