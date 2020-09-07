$(document).on('turbolinks:load', function() {
  $(function () {
    $('.datepicker').datepicker({
      closeText: 'Cerrar',
      prevText: '<Ant',
      nextText: 'Sig>',
      currentText: 'Hoy',
      monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
      monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
      dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
      dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
      dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
      weekHeader: 'Sm',
      dateFormat: 'dd/mm/yy',
      firstDay: 1,
      isRTL: false,
      showMonthAfterYear: false,
      yearSuffix: ''
    });
    $("#entry_note_entry_date").on("dp.change", function (e) {
      $('#entry_note_out_date').data("DateTimePicker").minDate(e.date);
    });
    $("#entry_note_out_date").on("dp.change", function (e) {
      $('#entry_note_entry_date').data("DateTimePicker").maxDate(e.date);
    });
  });

  // Función para validar los select de origen y destino
  $('#new_entry_note').submit(function() {
    if($("#origin_id option:selected").val() == 0){
      // Additional code here to light up the input or display error message
      document.getElementsByClassName("entry_note_origin_id")[0].style.boxShadow = "0 0 5px red";
      if($("#destination_id option:selected").val() == 0){
        document.getElementsByClassName("entry_note_destination_id")[0].style.boxShadow = "0 0 5px red";
      }else {
        document.getElementsByClassName("entry_note_destination_id")[0].style.boxShadow = "0 0 5px green";
      }
      return false;
    }else{
      document.getElementsByClassName("entry_note_origin_id")[0].style.boxShadow = "0 0 5px green";
      if($("#destination_id option:selected").val() == 0){
        document.getElementsByClassName("entry_note_destination_id")[0].style.boxShadow = "0 0 5px red";
        return false;
      }else{
        return true;
      }
    }
  });
});