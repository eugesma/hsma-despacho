class RenameSectorNameFromSector < ActiveRecord::Migration[5.2]
  def change
    rename_column :sectors, :sector_name, :name
  end
end
