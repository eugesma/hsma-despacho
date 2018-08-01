class AddEntryNotesCountToSector < ActiveRecord::Migration[5.2]
  def up
    add_column :sectors, :entry_notes_count, :integer, default: 0
    Sector.reset_column_information
    Sector.all.each do |s|
      s.update_attribute :entry_notes_count, s.origin_entries.length + s.destination_entries.length
    end
  end
  def down
    remove_column :sectors, :entry_notes_count
  end
end
