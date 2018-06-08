class AddAuthorToNotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :entry_notes, :author, index: true
  end
end
