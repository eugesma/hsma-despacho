class DropDescriptionFromSectors < ActiveRecord::Migration[5.2]
  def change
    remove_column :sectors, :description
  end
end
