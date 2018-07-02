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
});
