$(document).ready(function(){
    $('.btn-success, .btn-primary').bind('click',function(){
        window.location.href = "/sort/top10";
        $("body").addClass("loading");
    });

    $('.btn-danger,.btn-info').bind('click',function(){
        window.location.href = "/sort/bottom10";
        $("body").addClass("loading");
    });

    $('button.btn.btn-default').bind('click',function(){
        cityName = encodeURI($('input.form-control').val());
        window.location.href = "/zones/" + cityName;
        $("body").addClass("loading");
    });
});