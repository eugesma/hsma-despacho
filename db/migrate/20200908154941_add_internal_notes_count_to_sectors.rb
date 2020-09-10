class AddInternalNotesCountToSectors < ActiveRecord::Migration[5.2]
  def change
    add_column :sectors, :internal_notes_count, :integer, default: 0
  end
end
