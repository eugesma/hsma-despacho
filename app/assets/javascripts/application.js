// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery-ui
//= require chosen-jquery
//= require bootstrap-select
//= require highcharts
//= require Chart.bundle
//= require chartkick
//= require moment
//= require moment-timezone-with-data
//= require tempusdominus-bootstrap-4
//= require moment/es.js
//= require popper
//= require bootstrap
//= require font_awesome5
//= require rails-ujs
//= require filterrific/filterrific-jquery
//= require activestorage
//= require turbolinks
//= require_tree .

// Se oculta el flash message
$(document).on('turbolinks:load', function() {
  window.setTimeout(function() {
      $(".alert").fadeTo(500, 0).slideUp(500, function(){
          $(this).remove();
      });
  }, 2000);

  $('.selectpicker').selectpicker({style: ''});

  $("#internal_note_entry_date").on("dp.change", function (e) {
    $('#datepicker2').data("DateTimePicker").minDate(e.date);
  });

  $(".datepicker2").on("dp.change", function (e) {
    $('#datepicker1').data("DateTimePicker").maxDate(e.date);
  });
  
  $('.datepicker1, .datepicker2').datepicker({
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
});

$("#menu-toggle").click(function(e) {
  e.preventDefault();
  $("#wrapper").toggleClass("toggled");
});

$(function () {
  $('.datepicker1, .datepicker2').datepicker({
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

  $('.selectpicker').selectpicker({style: ''});
  
  $(".datepicker1").on("dp.change", function (e) {
    console.log("entró");
    $('#datepicker2').data("DateTimePicker").minDate(e.date);
  });

  $('.chosen-select').chosen({
    allow_single_deselect: true,
    no_results_text: 'No se encontró el resultado',
    width: '230px'});
  
  $(".datepicker2").on("dp.change", function (e) {
    $('#datepicker1').data("DateTimePicker").maxDate(e.date);
  });
});