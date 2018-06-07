class CreateSectors < ActiveRecord::Migration[5.2]
  def change
    create_table :sectors do |t|
      t.string :sector_name
      t.string :description
      t.references :professional, foreign_key: true
      t.references :entry_note, foreign_key: true

      t.timestamps
    end
  end
end
