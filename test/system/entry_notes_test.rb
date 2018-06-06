require "application_system_test_case"

class EntryNotesTest < ApplicationSystemTestCase
  setup do
    @entry_note = entry_notes(:one)
  end

  test "visiting the index" do
    visit entry_notes_url
    assert_selector "h1", text: "Entry Notes"
  end

  test "creating a Entry note" do
    visit entry_notes_url
    click_on "New Entry Note"

    fill_in "Entry Date", with: @entry_note.entry_date
    fill_in "Note Number", with: @entry_note.note_number
    fill_in "Out Date", with: @entry_note.out_date
    fill_in "Reference", with: @entry_note.reference
    click_on "Create Entry note"

    assert_text "Entry note was successfully created"
    click_on "Back"
  end

  test "updating a Entry note" do
    visit entry_notes_url
    click_on "Edit", match: :first

    fill_in "Entry Date", with: @entry_note.entry_date
    fill_in "Note Number", with: @entry_note.note_number
    fill_in "Out Date", with: @entry_note.out_date
    fill_in "Reference", with: @entry_note.reference
    click_on "Update Entry note"

    assert_text "Entry note was successfully updated"
    click_on "Back"
  end

  test "destroying a Entry note" do
    visit entry_notes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Entry note was successfully destroyed"
  end
end
