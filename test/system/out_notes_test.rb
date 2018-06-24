require "application_system_test_case"

class OutNotesTest < ApplicationSystemTestCase
  setup do
    @out_note = out_notes(:one)
  end

  test "visiting the index" do
    visit out_notes_url
    assert_selector "h1", text: "Out Notes"
  end

  test "creating a Out note" do
    visit out_notes_url
    click_on "New Out Note"

    fill_in "Entry Date", with: @out_note.entry_date
    fill_in "Note Number", with: @out_note.note_number
    fill_in "Out Date", with: @out_note.out_date
    fill_in "Reference", with: @out_note.reference
    fill_in "Subse Number", with: @out_note.subse_number
    fill_in "Zonal Pass", with: @out_note.zonal_pass
    click_on "Create Out note"

    assert_text "Out note was successfully created"
    click_on "Back"
  end

  test "updating a Out note" do
    visit out_notes_url
    click_on "Edit", match: :first

    fill_in "Entry Date", with: @out_note.entry_date
    fill_in "Note Number", with: @out_note.note_number
    fill_in "Out Date", with: @out_note.out_date
    fill_in "Reference", with: @out_note.reference
    fill_in "Subse Number", with: @out_note.subse_number
    fill_in "Zonal Pass", with: @out_note.zonal_pass
    click_on "Update Out note"

    assert_text "Out note was successfully updated"
    click_on "Back"
  end

  test "destroying a Out note" do
    visit out_notes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Out note was successfully destroyed"
  end
end
