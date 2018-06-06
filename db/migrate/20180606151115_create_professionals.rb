class CreateProfessionals < ActiveRecord::Migration[5.2]
  def change
    create_table :professionals do |t|
      t.string :first_name
      t.string :last_name
      t.integer :dni
      t.string :enrollment
      t.string :address
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
