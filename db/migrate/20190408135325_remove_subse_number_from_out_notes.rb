class RemoveSubseNumberFromOutNotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :out_notes, :subse_number
  end
end
