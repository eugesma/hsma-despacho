require 'test_helper'

class EntryNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @entry_note = entry_notes(:one)
  end

  test "should get index" do
    get entry_notes_url
    assert_response :success
  end

  test "should get new" do
    get new_entry_note_url
    assert_response :success
  end

  test "should create entry_note" do
    assert_difference('EntryNote.count') do
      post entry_notes_url, params: { entry_note: { entry_date: @entry_note.entry_date, note_number: @entry_note.note_number, out_date: @entry_note.out_date, reference: @entry_note.reference } }
    end

    assert_redirected_to entry_note_url(EntryNote.last)
  end

  test "should show entry_note" do
    get entry_note_url(@entry_note)
    assert_response :success
  end

  test "should get edit" do
    get edit_entry_note_url(@entry_note)
    assert_response :success
  end

  test "should update entry_note" do
    patch entry_note_url(@entry_note), params: { entry_note: { entry_date: @entry_note.entry_date, note_number: @entry_note.note_number, out_date: @entry_note.out_date, reference: @entry_note.reference } }
    assert_redirected_to entry_note_url(@entry_note)
  end

  test "should destroy entry_note" do
    assert_difference('EntryNote.count', -1) do
      delete entry_note_url(@entry_note)
    end

    assert_redirected_to entry_notes_url
  end
end
