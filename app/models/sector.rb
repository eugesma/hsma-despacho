class Sector < ApplicationRecord
  include PgSearch
  # Validaciones
  validates_presence_of :name
  validates_uniqueness_of :name

  # Relaciones
  has_many :origin_entries, class_name: 'EntryNote', foreign_key: 'origin_id'
  has_many :destination_entries, class_name: 'EntryNote', foreign_key: 'destination_id'
  has_many :origin_outs, class_name: 'OutNote', foreign_key: 'origin_id', :dependent => :destroy
  has_many :destination_outs, class_name: 'OutNote', foreign_key: 'destination_id', :dependent => :delete_all
  has_many :origin_internal_notes, class_name: 'InternaNote', foreign_key: 'origin_id'

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_name,
      :created_at,
      :updated_at,
    ]
  )

  pg_search_scope :search_name,
  against: :name,
  :using => { :tsearch => {:prefix => true} },
  :ignoring => :accents

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^fecha_creado_/s
      # Ordenamiento por fecha de creación en la BD
      order("sectors.created_at #{ direction }")
    when /^fecha_modificado_/
      # Ordenamiento por fecha de modicicaion en la BD
      order("sectors.updated_at #{ direction }")
    when /^entrantes_/
      # Ordenamiento por cantidad de notas entrantes
      order("sectors.entry_notes_count #{ direction }")
    when /^salientes_/
      # Ordenamiento por cantidad de notas salientes
      order("sectors.out_notes_count #{ direction }")
    when /^nombre_/
      # Ordenamiento por nombre de sector
      order("LOWER(sectors.name) #{ direction }")
    else
      # Si no existe la opcion de ordenamiento se levanta la excepción
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :created_at, lambda { |reference_time|
    where('sectors.created_at >= ?', reference_time)
  }

  scope :updated_at, lambda { |reference_time|
    where('sectors.updated_at >= ?', reference_time)
  }

  # Método para establecer las opciones del select input del filtro
  # Es llamado por el controlador como parte de `initialize_filterrific`.
  def self.options_for_sorted_by
    [
      ['Creación (desc)', 'fecha_creado_desc'],
      ['Nombre (asc)', 'nombre_asc'],
      ['Modificacion (a-z)', 'fecha_modificado_asc'],
    ]
  end

  def count_entry_label
    if self.entry_notes_count > 0; return 'success'; else; return 'default'; end
  end

  def count_out_label
    if self.out_notes_count > 0; return 'success'; else; return 'default'; end
  end
end
