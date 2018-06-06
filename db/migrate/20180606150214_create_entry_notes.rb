class CreateEntryNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_notes do |t|
      t.integer :note_number
      t.text :reference
      t.datetime :entry_date
      t.datetime :out_date

      t.timestamps
    end
  end
end
