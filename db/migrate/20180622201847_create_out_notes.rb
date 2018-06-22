class CreateOutNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :out_notes do |t|
      t.integer :note_number
      t.text :reference
      t.integer :zonal_pass
      t.integer :subse_number
      t.datetime :entry_date
      t.datetime :out_date

      t.timestamps
    end
    add_reference :out_notes, :author, index: true
    add_reference :out_notes, :origin, index: true
    add_reference :out_notes, :destination, index: true
  end
end
