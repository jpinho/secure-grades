//globals
function validGradesOnly() {
    //remove non integers
    this.value = $.trim(this.value).replace(/[^0-9]*/g, '');
    if (isNaN(parseInt(this.value))) return;

    //valid grades between 0 and 20
    var v = parseInt(this.value);
    var neg = v < 0;
    if (v < 0 || v > 20) this.value = this.value.substr(0 + (neg ? 1 : 0), this.value.length + (neg ? 0 : -1));

    this.value = parseInt(this.value);
}

//helper functions
function getData() {
    var data = {
        campus: $('#ddlCampus option:selected').text(),
        course: $('#ddlCurso option:selected').text(),
        classe: $('#ddlClass option:selected').text(),
        evaluation: $('#ddlEvaluationType option:selected').text(),
        grades: new Array()
    };

    $('.grade-row').each(function () {
        var studID = $(this).find('.student-id').text();
        var studName = $(this).find('.student-name').text();
        var studGrade = $(this).find('.student-grade').text();

        data.grades.push([studID, studName, studGrade]);
    });

    return data;
}

function editEnabled(enable) {
    var $query = $('#content').find('select, input');

    if (!enable) {
        $query.attr('disabled', 'disabled');
    }
    else $query.removeAttr('disabled');
}


//core functions
function submitGrades() {
    var data = getData();

    $('#lbSubmitGrades').hide();
    $('#messageBox').removeClass('alert-danger').addClass('alert-success')
        .html('A assinar as notas dos alunos num servidor seguro... seremos breves!').show();

    $('.progress').show();
    $('.progress-bar').width('45%');
    $('#workspace').scrollTop($('#workspace').height());
    editEnabled(false);

    PageMethods.SubmitGrades(data.campus, data.course, data.classe, data.evaluation, data.grades,
        function (result) {
            //notify user
            $('#messageBox').html(
                'Os dados foram assinados com sucesso!' +
                '<div class="signature"><pre>"' + result.signedData + '"</pre></div>'
            );

            //update progress
            $('.progress-bar').width('80%');
            $('#confirmBox').show();
            $('#workspace').scrollTop($('#workspace').height());

            //setup confirm actions
            $('#lbConfirmYes').click(publishGrades);
            $('#lbConfirmNo').click(cancelPublish);
        },
        function (error) {
            editEnabled(true);
            $('.progress').hide();
            $('.progress-bar').width('100%');
            $('#messageBox').removeClass('alert-success').addClass('alert-danger');

            $('#messageBox').html(error.get_exceptionType() + ' - ' + error.get_message() + ' --> ' + error.get_stackTrace())
                .delay(10000).slideUp();
            
            $('#lbSubmitGrades').show();
            $('#workspace').scrollTop($('#workspace').height());
        }
    );
}

function publishGrades() {
    $('#messageBox').html('A enviar a pauta assinada para o servidor de publicação...');
    $('.progress-bar').width('85%');
    $('#confirmBox').hide();

    PageMethods.PublishGrades(
        function (result) {
            //notify user
            $('#messageBox').removeClass('alert-danger').addClass('alert-success').html(
                'As notas foram publicadas com sucesso! <br/>Estado: "'+ result +'"'
            );

            //update progress
            $('.progress-bar').width('100%');
            setTimeout(function () { $('.progress').slideUp(); }, 2000);
            $('#workspace').scrollTop($('#workspace').height());
        },
        function (error) {
            $('.progress').hide();
            $('.progress-bar').width('100%');
            $('#messageBox').removeClass('alert-success').addClass('alert-danger');

            $('#messageBox').html('Oops!... Isto é embaraçoso, mas parece ter ocorrido um erro, por favor tenta novamente.<br/><br/>'
                + error.get_exceptionType() + ' - ' + error.get_message() + ' --> ' + error.get_stackTrace())
                .delay(10000).slideUp();

            $('#lbSubmitGrades').show();
            $('#workspace').scrollTop($('#workspace').height());
        }
    );
}

function cancelPublish() {
    editEnabled(true);
    $('#confirmBox').hide();
    $('#lbSubmitGrades').show();

    $('.progress').hide();
    $('.progress-bar').width('40%');

    $('#messageBox').removeClass('alert-success').addClass('alert-danger');
    $('#messageBox').html('Publicação cancelada!').delay(5000).slideUp();
}

//workspace auto-size
$(document).ready(function () {
    var resize = function () {
        $('#workspace').width($(window).outerWidth() - (($(window).outerWidth() - 960) >> 1));
        $('#workspace').height($(window).outerHeight() - $('header').outerHeight() - $('footer').outerHeight());
        $('#workspace .body').css('min-height', $('#workspace').height());
    };

    $(window).resize(function () { resize(); });
    resize();
});