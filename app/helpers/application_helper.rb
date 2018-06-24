module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end
  
  def paginate(collection, params= {})
    will_paginate collection, params.merge(renderer: BootstrapPagination::Rails, previous_label: 'Atras', next_label: 'Siguiente')
  end

  def active_class(link_path)
    current_page?(link_path) ? 'active' : ""
  end
end
