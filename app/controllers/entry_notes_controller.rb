class EntryNotesController < ApplicationController
  before_action :set_entry_note, only: [:show, :edit, :update, :destroy, :delete, :show_image, :edit_pass]

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
        :search_text,
        :entry_date_at,
        :out_date_at,
        :search_number,
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
      format.html
      format.js
    end
  end

  # GET /entry_notes/new
  def new
    authorize EntryNote
    @entry_note = EntryNote.new
    @sectors = Sector.all
    @order_type = 'nota'
  end

  # GET /entry_notes/new_pass
  def new_pass
    authorize EntryNote
    @entry_note = EntryNote.new
    @sectors = Sector.all
    @order_type = 'pase'
  end  

  # GET /entry_notes/1/edit
  def edit
    authorize @entry_note
    @sectors = Sector.all
  end

  # GET /entry_notes/1/edit_pass
  def edit_pass
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
      if @entry_note.save
        begin
          if @entry_note.nota?
            flash[:success] = 'La nota se ha cargado correctamente'
          elsif @entry_note.pase?
            flash[:success] = 'El pase se ha cargado correctamente'
          end
        rescue ArgumentError => e
          flash[:alert] = e.message
        end
        format.html { redirect_to @entry_note }
      else
        if entry_note_params[:order_type] == 'nota'
          @order_type = 'nota'
          @sectors = Sector.all
          flash[:error] = "La nota no se ha podido cargar."
          format.html { render :new }
        elsif entry_note_params[:order_type] == 'pase'
          @order_type = 'pase'
          @sectors = Sector.all
          flash[:error] = "El pase no se ha podido cargar."
          format.html { render :new_pass }
        end
      end
    end
  end

  # PATCH/PUT /entry_notes/1
  # PATCH/PUT /entry_notes/1.json
  def update
    authorize @entry_note
    respond_to do |format|
      if @entry_note.update(entry_note_params)
        if @entry_note.nota?
          flash[:success] = 'La nota se ha modificado correctamente'
        elsif @entry_note.pase?
          flash[:success] = 'El pase se ha modificado correctamente'
        end
        format.html { redirect_to @entry_note }
      else
        if @entry_note.nota?
          @order_type = 'nota'
          @sectors = Sector.all
          flash[:error] = "La nota no se ha podido modificar."
          format.html { render :edit }
        elsif @entry_note.pase?
          @sectors = Sector.all
          @order_type = 'pase'
          flash[:error] = "El pase no se ha podido modificar."
          format.html { render :edit_pass }
        end
      end
    end
  end

  # DELETE /entry_notes/1
  # DELETE /entry_notes/1.json
  def destroy
    authorize @entry_note
    @number = @entry_note.note_number
    @order_type = @entry_note.order_type
    @entry_note.destroy
    respond_to do |format|
      flash[:success] = @order_type.humanize+" entrante número "+@number.to_s+" se ha eliminado correctamente."
      format.html { redirect_to action: "index" } 
    end
  end

  # GET /entry_note/1/delete
  def delete
    authorize @entry_note
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
      params.require(:entry_note).permit(:note_number, :destination_id, :origin_id,
                                          :zonal_pass, :subse_number, :order_type,
                                         :reference, :entry_date, :out_date, files:[])
    end
end
