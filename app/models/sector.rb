class Sector < ApplicationRecord
  has_many :origins, class_name: 'EntryNote', foreign_key: 'origin_id'
  has_many :destinations, class_name: 'EntryNote', foreign_key: 'destination_id'

  has_many :origins, class_name: 'OutNote', foreign_key: 'origin_id'
  has_many :destinations, class_name: 'OutNote', foreign_key: 'destination_id'
end
