class EntryNotesController < ApplicationController
  before_action :set_entry_note, only: [:show, :edit, :update, :destroy]

  # GET /entry_notes
  # GET /entry_notes.json
  def index
    @entry_notes = EntryNote.paginate(:page => params[:page], :per_page => 8)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /entry_notes/1
  # GET /entry_notes/1.json
  def show
    respond_to do |format|
      format.js
    end
  end

  # GET /entry_notes/new
  def new
    @entry_note = EntryNote.new
  end

  # GET /entry_notes/1/edit
  def edit
  end

  # POST /entry_notes
  # POST /entry_notes.json
  def create
    @entry_note = EntryNote.new(entry_note_params)
    @entry_note.author = current_user

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
    @number = @entry_note.note_number
    @entry_note.destroy
    respond_to do |format|
      flash.now[:success] = "La nota entrante número "+@number.to_s+" se ha eliminado correctamente."
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
      params.require(:entry_note).permit(:note_number, :reference, :entry_date, :out_date)
    end
end
