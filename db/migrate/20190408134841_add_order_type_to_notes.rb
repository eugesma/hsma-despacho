class AddOrderTypeToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :entry_notes, :order_type, :integer, default: 0
    add_column :out_notes, :order_type, :integer, default: 0
  end
end
