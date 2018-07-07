class ChartsController < ApplicationController
  def by_day_entry_notes
    render json: EntryNote.group_by_day(:entry_date, range: 2.weeks.ago.midnight..Time.now, format: "%d/%m").count
  end

  def by_month_entry_notes
    render json: EntryNote.group_by_month_of_year(:entry_date).count.map{ |k, v| [I18n.t("date.month_names")[k], v]}
  end

  def by_day_out_notes
    render json: OutNote.group_by_day(:entry_date, range: 2.weeks.ago.midnight..Time.now, format: "%d/%m").count
  end

  def by_month_out_notes
    render json: OutNote.group_by_month_of_year(:entry_date).count.map{ |k, v| [I18n.t("date.month_names")[k], v]}
  end

  def by_sector_entry_notes
    render json: EntryNote.joins("JOIN sectors AS origins ON origins.id = entry_notes.origin_id").group('origins.sector_name').count
  end

  def by_sector_out_notes
    render json: OutNote.joins("JOIN sectors AS origins ON origins.id = out_notes.origin_id").group('origins.sector_name').count
  end
end
