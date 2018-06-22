class OutNotesController < ApplicationController
  before_action :set_out_note, only: [:show, :edit, :update, :destroy]

  # GET /out_notes
  # GET /out_notes.json
  def index
    @out_notes = OutNote.all
  end

  # GET /out_notes/1
  # GET /out_notes/1.json
  def show
  end

  # GET /out_notes/new
  def new
    @out_note = OutNote.new
  end

  # GET /out_notes/1/edit
  def edit
  end

  # POST /out_notes
  # POST /out_notes.json
  def create
    @out_note = OutNote.new(out_note_params)

    respond_to do |format|
      if @out_note.save
        format.html { redirect_to @out_note, notice: 'Out note was successfully created.' }
        format.json { render :show, status: :created, location: @out_note }
      else
        format.html { render :new }
        format.json { render json: @out_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /out_notes/1
  # PATCH/PUT /out_notes/1.json
  def update
    respond_to do |format|
      if @out_note.update(out_note_params)
        format.html { redirect_to @out_note, notice: 'Out note was successfully updated.' }
        format.json { render :show, status: :ok, location: @out_note }
      else
        format.html { render :edit }
        format.json { render json: @out_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /out_notes/1
  # DELETE /out_notes/1.json
  def destroy
    @out_note.destroy
    respond_to do |format|
      format.html { redirect_to out_notes_url, notice: 'Out note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_out_note
      @out_note = OutNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def out_note_params
      params.require(:out_note).permit(:note_number, :reference, :zonal_pass, :subse_number, :entry_date, :out_date)
    end
end
