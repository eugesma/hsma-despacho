$(function () {
    $('#datepicker3').datetimepicker();
    $('#datepicker4').datetimepicker({
        useCurrent: false //Important! See issue #1075
    });
    $("#datepicker3").on("dp.change", function (e) {
        $('#datepicker4').data("DateTimePicker").minDate(e.date);
    });
    $("#datepicker4").on("dp.change", function (e) {
        $('#datepicker3').data("DateTimePicker").maxDate(e.date);
    });
});
