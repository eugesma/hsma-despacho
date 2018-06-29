$('#filter').on('hidden.bs.collapse', function (e) {
    alert('Event fired on #' + e.currentTarget.id);
})

$(function () {
    $('#datepicker1').datetimepicker();
    $('#datepicker2').datetimepicker({
        useCurrent: false //Important! See issue #1075
    });
    $("#datepicker1").on("dp.change", function (e) {
        $('#datepicker2').data("DateTimePicker").minDate(e.date);
    });
    $("#datepicker2").on("dp.change", function (e) {
        $('#datepicker1').data("DateTimePicker").maxDate(e.date);
    });
    $('#author_id').chosen({
        allow_single_deselect: true,
        no_results_text: 'No se encontró el resultado',
        width: '200px'});
});
