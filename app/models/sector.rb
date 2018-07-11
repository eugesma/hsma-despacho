class Sector < ApplicationRecord
  has_many :origins, class_name: 'EntryNote', foreign_key: 'origin_id'
  has_many :destinations, class_name: 'EntryNote', foreign_key: 'destination_id'

  has_many :origins, class_name: 'OutNote', foreign_key: 'origin_id', :dependent => :destroy
  has_many :destinations, class_name: 'OutNote', foreign_key: 'destination_id', :dependent => :delete_all

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :created_at,
      :updated_at,
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
    num_or_conds = 1
    where(
      terms.map { |term|
        "(LOWER(sectors.sector_name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

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
    when /^nombre_/
      # Ordenamiento por nombre de sector
      order("LOWER(sectors.sector_name) #{ direction }")
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
end
