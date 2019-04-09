$ ->
  if $('.pagination').length && $('#entry-notes').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Cargando más items...")
        $.getScript(url)
    $(window).scroll()