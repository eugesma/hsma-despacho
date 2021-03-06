$(function () {
    $('#datepicker3').datepicker({
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
    $('#datepicker4').datepicker({
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
    $("#datepicker3").on("dp.change", function (e) {
        $('#datepicker4').data("DateTimePicker").minDate(e.date);
    });
    $("#datepicker4").on("dp.change", function (e) {
        $('#datepicker3').data("DateTimePicker").maxDate(e.date);
    });

});
$(document).on('turbolinks:load', function() {
    var dateNow = new Date();
    $(function () {
        $('#out_note_entry_date').datepicker({
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
        $('#out_note_out_date').datepicker({
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
        $("#out_note_entry_date").on("dp.change", function (e) {
            $('#out_note_out_date').data("DateTimePicker").minDate(e.date);
        });
        $("#out_note_out_date").on("dp.change", function (e) {
            $('#out_note_entry_date').data("DateTimePicker").maxDate(e.date);
        });
    });

    $('.chosen-select').chosen({
        allow_single_deselect: true,
        no_results_text: 'No se encontró el resultado',
        width: '230px'});

    // Función para validar los select de origen y destino
    $('#new_out_note').submit(function() {
    if($("#origin_id option:selected").val() == 0){
        // Additional code here to light up the input or display error message
        document.getElementsByClassName("out_note_origin_id")[0].style.boxShadow = "0 0 5px red";
        if($("#destination_id option:selected").val() == 0){
        document.getElementsByClassName("out_note_destination_id")[0].style.boxShadow = "0 0 5px red";
        }else {
        document.getElementsByClassName("out_note_destination_id")[0].style.boxShadow = "0 0 5px green";
        }
        return false;
    }else{
        document.getElementsByClassName("out_note_origin_id")[0].style.boxShadow = "0 0 5px green";
        if($("#destination_id option:selected").val() == 0){
        document.getElementsByClassName("out_note_destination_id")[0].style.boxShadow = "0 0 5px red";
        return false;
        }else{
        return true;
        }
    }
    });

    // Función para mostrar el nombre del archivo en el label
    $("#imgInp").change(function() {
    var input = $(this),
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    document.getElementById('file-name').value = label;
    readURL(this);
    });

    // Función para mostrar imagen seleccionada
    function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
        $('#img-upload').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
    }
    }

    // Función para validar formato del archivo
    $("#imgInp").change(function() {
    var input = this;
    var fileName = document.getElementById('file-name');
    var maxExceededMessage = "Esta imagen supera el máximo de tamaño permitido (5 MB)";
    var extErrorMessage = "Solo se permiten imágenes con formato: .jpg, .jpeg, .gif o .png";
    var allowedExtension = ["jpg", "jpeg", "gif", "png"];

    var extName;
    var maxFileSize = $(input).data('max-file-size');
    var sizeExceeded = false;
    var extError = false;

    $.each(input.files, function() {
        if (this.size && maxFileSize && this.size > parseInt(maxFileSize)) {sizeExceeded=true;};
        extName = this.name.split('.').pop();
        if ($.inArray(extName, allowedExtension) == -1) {extError=true;};
    });
    if (sizeExceeded) {
        window.alert(maxExceededMessage);
        fileName.value = "Tamaño excedido";
        $(input).val('');
    };
    if (extError) {
        window.alert(extErrorMessage);
        fileName.value = "Formato inválido";
        $(input).val('');
    };
    });
});
