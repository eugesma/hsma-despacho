class InternalNote < ApplicationRecord
  include PgSearch
  
  # Relations
  belongs_to :author, class_name: 'User'
  belongs_to :origin, class_name: 'Sector', foreign_key: 'origin_id', counter_cache: true
  belongs_to :destination, class_name: 'Sector', foreign_key: 'destination_id', counter_cache: true
  has_many_attached :files

  validates_presence_of :entry_date, :out_date
  
  filterrific(
    available_filters: [
      :search_sector,
      :search_reference,
      :entry_date_at,
      :out_date_at,
      :search_number,
    ]
  )

  pg_search_scope :search_sector,
    :associated_against => {
      :origin => :sector_name,
      :destination => :sector_name
    },
    :using => {
      :tsearch => {:prefix => true}
    },
    :ignoring => :accents

  pg_search_scope :search_reference,
    against: :reference,
    :using => {
      :tsearch => {:prefix => true}
    },
    :ignoring => :accents
end
