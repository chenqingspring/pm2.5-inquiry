$(document).ready(function(){
    $('.btn-success, .btn-primary').bind('click',function(){
        window.location.href = "/top10";
        $("body").addClass("loading");
    });

    $('.btn-danger,.btn-info').bind('click',function(){
        window.location.href = "/bottom10";
        $("body").addClass("loading");
    });
});