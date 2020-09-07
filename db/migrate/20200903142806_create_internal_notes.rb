class CreateInternalNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :internal_notes do |t|
      t.references :origin, index: true
      t.references :destination, index: true
      t.date :entry_date
      t.date :out_date
      t.text :reference
      t.references :author, index: true

      t.timestamps
    end
  end
end
