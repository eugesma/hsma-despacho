class EntryNotesController < ApplicationController
  before_action :set_entry_note, only: [:show, :edit, :update, :destroy]

  # GET /entry_notes
  # GET /entry_notes.json
  def index
    @entry_notes = EntryNote.all
  end

  # GET /entry_notes/1
  # GET /entry_notes/1.json
  def show
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
      if @entry_note.save
        format.html { redirect_to @entry_note, notice: 'Entry note was successfully created.' }
        format.json { render :show, status: :created, location: @entry_note }
      else
        format.html { render :new }
        format.json { render json: @entry_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entry_notes/1
  # PATCH/PUT /entry_notes/1.json
  def update
    respond_to do |format|
      if @entry_note.update(entry_note_params)
        format.html { redirect_to @entry_note, notice: 'Entry note was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry_note }
      else
        format.html { render :edit }
        format.json { render json: @entry_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entry_notes/1
  # DELETE /entry_notes/1.json
  def destroy
    @entry_note.destroy
    respond_to do |format|
      format.html { redirect_to entry_notes_url, notice: 'Entry note was successfully destroyed.' }
      format.json { head :no_content }
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
