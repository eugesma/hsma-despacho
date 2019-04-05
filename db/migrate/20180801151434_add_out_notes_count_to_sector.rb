class AddOutNotesCountToSector < ActiveRecord::Migration[5.2]
  def up
    add_column :sectors, :out_notes_count, :integer, default: 0

    Sector.reset_column_information
    Sector.all.each do |s|
      s.update_attribute :out_notes_count, s.origin_outs.length + s.destination_outs.length
    end
  end
  def down
    remove_column :sectors, :out_notes_count
  end
end
