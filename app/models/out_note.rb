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
end