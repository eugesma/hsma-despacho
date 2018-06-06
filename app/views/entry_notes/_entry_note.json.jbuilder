json.extract! entry_note, :id, :note_number, :reference, :entry_date, :out_date, :created_at, :updated_at
json.url entry_note_url(entry_note, format: :json)
