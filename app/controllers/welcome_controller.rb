class WelcomeController < ApplicationController
  def index
    @last_entry_notes = EntryNote.limit(3).order(created_at: :desc)
    @last_out_notes = OutNote.limit(3).order(created_at: :desc)
  end
end
