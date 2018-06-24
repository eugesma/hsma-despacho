require 'test_helper'

class OutNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @out_note = out_notes(:one)
  end

  test "should get index" do
    get out_notes_url
    assert_response :success
  end

  test "should get new" do
    get new_out_note_url
    assert_response :success
  end

  test "should create out_note" do
    assert_difference('OutNote.count') do
      post out_notes_url, params: { out_note: { entry_date: @out_note.entry_date, note_number: @out_note.note_number, out_date: @out_note.out_date, reference: @out_note.reference, subse_number: @out_note.subse_number, zonal_pass: @out_note.zonal_pass } }
    end

    assert_redirected_to out_note_url(OutNote.last)
  end

  test "should show out_note" do
    get out_note_url(@out_note)
    assert_response :success
  end

  test "should get edit" do
    get edit_out_note_url(@out_note)
    assert_response :success
  end

  test "should update out_note" do
    patch out_note_url(@out_note), params: { out_note: { entry_date: @out_note.entry_date, note_number: @out_note.note_number, out_date: @out_note.out_date, reference: @out_note.reference, subse_number: @out_note.subse_number, zonal_pass: @out_note.zonal_pass } }
    assert_redirected_to out_note_url(@out_note)
  end

  test "should destroy out_note" do
    assert_difference('OutNote.count', -1) do
      delete out_note_url(@out_note)
    end

    assert_redirected_to out_notes_url
  end
end
