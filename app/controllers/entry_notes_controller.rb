class EntryNotesController < ApplicationController
  before_action :set_entry_note, only: [:show, :edit, :update, :destroy, :delete, :show_image]

  # GET /entry_notes
  # GET /entry_notes.json
  def index
    authorize EntryNote
    @filterrific = initialize_filterrific(
      EntryNote,
      params[:filterrific],
      select_options: {
        sorted_by: EntryNote.options_for_sorted_by
      },
      persistence_id: false,
      default_filter_params: {sorted_by: 'created_at_desc'},
      available_filters: [
        :sorted_by,
        :search_query,
        :entry_date_at,
        :out_date_at,
        :with_note_number,
      ],
    ) or return
    @entry_notes = @filterrific.find.page(params[:page]).per_page(10)

    respond_to do |format|
      format.html
      format.js
    end
    rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
  end

  # GET /entry_notes/1
  # GET /entry_notes/1.json
  def show
    authorize @entry_note
    respond_to do |format|
      format.js
    end
  end

  # GET /entry_notes/new
  def new
    authorize EntryNote
    @entry_note = EntryNote.new
    @sectors = Sector.all
  end

  # GET /entry_notes/1/edit
  def edit
    authorize @entry_note
    @sectors = Sector.all
  end

  # POST /entry_notes
  # POST /entry_notes.json
  def create
    @entry_note = EntryNote.new(entry_note_params)
    @entry_note.author = current_user
    authorize @entry_note

    respond_to do |format|
      if @entry_note.save!
        flash.now[:success] = "La nota entrante número "+@entry_note.note_number.to_s+" se ha creado correctamente."
        format.js
      else
        flash.now[:error] = "La nota entrante no se ha podido crear."
        format.js
      end
    end
  end

  # PATCH/PUT /entry_notes/1
  # PATCH/PUT /entry_notes/1.json
  def update
    authorize @entry_note

    respond_to do |format|
      if @entry_note.update_attributes(entry_note_params)
        flash.now[:success] = "La nota entrante número "+@entry_note.note_number.to_s+" se ha modificado correctamente."
        format.js
      else
        flash.now[:error] = "La nota entrante número "+@entry_note.note_number.to_s+" no se ha podido modificar."
        format.js
      end
    end
  end

  # DELETE /entry_notes/1
  # DELETE /entry_notes/1.json
  def destroy
    authorize @entry_note
    @number = @entry_note.note_number
    @entry_note.destroy
    respond_to do |format|
      flash.now[:success] = "La nota entrante número "+@number.to_s+" se ha eliminado correctamente."
      format.js
    end
  end

  # GET /entry_note/1/delete
  def delete
    authorize @entry_note

    respond_to do |format|
      format.js
    end
  end

  # GET /entry_note/1/show_image
  def show_image
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry_note
      @entry_note = EntryNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_note_params
      params.require(:entry_note).permit(:note_number, :destination_id, :origin_id, :reference, :entry_date, :out_date, :image)
    end
end
