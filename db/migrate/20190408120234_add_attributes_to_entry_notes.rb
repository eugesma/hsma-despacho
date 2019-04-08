class AddAttributesToEntryNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :entry_notes, :zonal_pass, :integer
    add_column :entry_notes, :subse_number, :integer
  end
end
