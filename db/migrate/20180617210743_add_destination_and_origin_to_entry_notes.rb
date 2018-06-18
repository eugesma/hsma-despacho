class AddDestinationAndOriginToEntryNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :entry_notes, :origin, index: true
    add_reference :entry_notes, :destination, index: true
  end
end
