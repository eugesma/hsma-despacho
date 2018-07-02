class OutNote < ApplicationRecord
  validates_presence_of :author
  validates_presence_of :reference
  validates_presence_of :note_number
  validates_presence_of :zonal_pass
  validates_presence_of :destination
  validates_presence_of :origin


  belongs_to :author, class_name: 'User'
  belongs_to :origin, class_name: 'Sector', foreign_key: 'origin_id'
  belongs_to :destination, class_name: 'Sector', foreign_key: 'destination_id'
  has_one_attached :image

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :entry_date_at,
      :out_date_at,
      :with_note_number,
    ]
  )

  # define ActiveRecord scopes for
  # :search_query, :sorted_by, :date_received_at
  scope :search_query, lambda { |query|
    #Se retorna nil si no hay texto en la query
    return nil  if query.blank?

    # Se pasa a minusculas para busqueda en postgresql
    # Luego se dividen las palabras en claves individuales
    terms = query.downcase.split(/\s+/)

    # Remplaza "*" con "%" para busquedas abiertas con LIKE
    # Agrega '%', remueve los '%' duplicados
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }

    # Cantidad de condiciones.
    num_or_conds = 2
    where(
      terms.map { |term|
        "(LOWER(origins.sector_name) LIKE ? OR LOWER(destinations.sector_name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    ).joins("INNER JOIN sectors AS origins ON origins.id = out_notes.origin_id").joins("INNER JOIN sectors AS destinations ON destinations.id = out_notes.destination_id")
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/s
      # Ordenamiento por fecha de creación en la BD
      order("out_notes.created_at #{ direction }")
    when /^numero_/
      # Ordenamiento por el numero de entrada
      order("out_notes.note_number #{ direction }")
    when /^origen_/
      # Ordenamiento por nombre de origen
      order("LOWER(sectors.sector_name) #{ direction }").joins("INNER JOIN sectors ON sectors.id = out_notes.origin_id")
    when /^destino_/
      # Ordenamiento por nombre de destino
      order("LOWER(sectors.sector_name) #{ direction }").joins("INNER JOIN sectors ON sectors.id = out_notes.destination_id")
    when /^fecha_entrada_/
      # Ordenamiento por la fecha de recepción
      order("out_notes.entry_date #{ direction }")
    when /^fecha_salida_/
      # Ordenamiento por la fecha de dispensación
      order("out_notes.out_date #{ direction }")
    else
      # Si no existe la opcion de ordenamiento se levanta la excepción
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :entry_date_at, lambda { |reference_time|
    where('out_notes.entry_date >= ?', reference_time)
  }

  scope :out_date_at, lambda { |reference_time|
    where('out_notes.out_date >= ?', reference_time)
  }

  scope :with_note_number, lambda { |number|
    where('out_notes.note_number = ?', number)
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
