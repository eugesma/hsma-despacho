class EntryNote < ApplicationRecord
  validates_presence_of :author
  validates_presence_of :reference
  validates_presence_of :note_number

  belongs_to :author, class_name: 'User'
end
