$(document).ready(function () {
    $('.close').click(function(){
        $(this).parent().hide();
    });
});

function openInfo(param){
    $(param).toggle();
}