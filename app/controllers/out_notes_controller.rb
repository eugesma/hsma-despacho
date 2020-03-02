class OutNotesController < ApplicationController
  before_action :set_out_note, only: [:show, :edit, :update, :destroy, :delete, :show_image, :edit_pass]

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
        :search_number,
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
      format.html
      format.js
    end
  end

  # GET /out_notes/new
  def new
    authorize OutNote
    @out_note = OutNote.new
    @sectors = Sector.all
    @order_type = 'nota'
  end

  # GET /out_notes/new_pass
  def new_pass
    authorize OutNote
    @out_note = OutNote.new
    @sectors = Sector.all
    @order_type = 'pase'
  end  

  # GET /out_notes/1/edit
  def edit
    authorize @out_note
    @sectors = Sector.all
  end

  # GET /out_notes/1/edit_pass
  def edit_pass
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
      if @out_note.save
        begin
          if @out_note.nota?
            flash[:success] = 'La nota se ha cargado correctamente'
          elsif @out_note.pase?
            flash[:success] = 'El pase se ha cargado correctamente'
          end
        rescue ArgumentError => e
          flash[:alert] = e.message
        end
        format.html { redirect_to @out_note }
      else
        if out_note_params[:order_type] == 'nota'
          @order_type = 'nota'
          @sectors = Sector.all
          flash[:error] = "La nota no se ha podido cargar."
          format.html { render :new }
        elsif out_note_params[:order_type] == 'pase'
          @order_type = 'pase'
          @sectors = Sector.all
          flash[:error] = "El pase no se ha podido cargar."
          format.html { render :new_pass }
        end
      end
    end
  end

  # PATCH/PUT /out_notes/1
  # PATCH/PUT /out_notes/1.json
  def update
    authorize @out_note
    respond_to do |format|
      if @out_note.update(out_note_params)
        if @out_note.nota?
          flash[:success] = 'La nota se ha modificado correctamente'
        elsif @out_note.pase?
          flash[:success] = 'El pase se ha modificado correctamente'
        end
        format.html { redirect_to @out_note }
      else
        if @out_note.nota?
          @order_type = 'nota'
          @sectors = Sector.all
          flash[:error] = "La nota no se ha podido modificar."
          format.html { render :edit }
        elsif @out_note.pase?
          @sectors = Sector.all
          @order_type = 'pase'
          flash[:error] = "El pase no se ha podido modificar."
          format.html { render :edit_pass }
        end
      end
    end
  end

  # DELETE /out_notes/1
  # DELETE /out_notes/1.json
  def destroy
    authorize @out_note
    @number = @out_note.note_number
    @order_type = @out_note.order_type
    @out_note.destroy
    respond_to do |format|
      flash[:success] = @order_type.humanize+" saliente número "+@number.to_s+" se ha eliminado correctamente."
      format.html { redirect_to action: "index" } 
    end
  end

  # GET /out_note/1/delete
  def delete
    authorize @out_note
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
                                       :reference, :zonal_pass, :order_type,
                                       :entry_date, :out_date, files:[])
    end
end
