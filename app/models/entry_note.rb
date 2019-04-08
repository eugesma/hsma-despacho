class EntryNote < ApplicationRecord
  include PgSearch

  enum order_type: { nota: 0, pase: 1 }

  # Validaciones
  validates_presence_of :author
  validates_presence_of :reference
  validates_presence_of :note_number
  validates_presence_of :destination
  validates_presence_of :origin
  validates_presence_of :out_date
  validates_presence_of :entry_date

  # Relaciones
  belongs_to :author, class_name: 'User'
  belongs_to :origin, class_name: 'Sector', foreign_key: 'origin_id', counter_cache: true
  belongs_to :destination, class_name: 'Sector', foreign_key: 'destination_id', counter_cache: true
  has_many_attached :files

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_text,
      :entry_date_at,
      :out_date_at,
      :with_note_number,
    ]
  )

  pg_search_scope :search_text,
  against: :reference,
  :associated_against => {
    :origin => :sector_name,
    :destination => :sector_name
  },
  :using => {
    :tsearch => {:prefix => true}
  },
  :ignoring => :accents

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/s
      # Ordenamiento por fecha de creación en la BD
      order("entry_notes.created_at #{ direction }")
    when /^numero_/
      # Ordenamiento por el numero de entrada
      order("entry_notes.note_number #{ direction }")
    when /^origen_/
      # Ordenamiento por nombre de origen
      order("LOWER(sectors.sector_name) #{ direction }").joins("INNER JOIN sectors ON sectors.id = entry_notes.origin_id")
    when /^destino_/
      # Ordenamiento por nombre de destino
      order("LOWER(sectors.sector_name) #{ direction }").joins("INNER JOIN sectors ON sectors.id = entry_notes.destination_id")
    when /^fecha_entrada_/
      # Ordenamiento por la fecha de recepción
      order("entry_notes.entry_date #{ direction }")
    when /^fecha_salida_/
      # Ordenamiento por la fecha de dispensación
      order("entry_notes.out_date #{ direction }")
    else
      # Si no existe la opcion de ordenamiento se levanta la excepción
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :entry_date_at, lambda { |reference_time|
    where('entry_notes.entry_date >= ?', reference_time)
  }

  scope :out_date_at, lambda { |reference_time|
    where('entry_notes.out_date >= ?', reference_time)
  }

  scope :with_note_number, lambda { |number|
    where('entry_notes.note_number = ?', number)
  }

  # Método para establecer las opciones del select input del filtro
  # Es llamado por el controlador como parte de `initialize_filterrific`.
  def self.options_for_sorted_by
    [
      ['Creación (desc)', 'created_at_desc'],
      ['Numero (asc)', 'numero_asc'],
      ['Origen (a-z)', 'origen_asc'],
      ['Destino (a-z)', 'destino_asc'],
      ['Fecha entrada(asc)', 'fecha_entrada_asc'],
      ['Fecha salida(asc)', 'fecha_salida_asc']
    ]
  end
end
