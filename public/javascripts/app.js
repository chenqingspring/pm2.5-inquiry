$(document).ready(function(){
    $('.btn-success, .btn-primary').bind('click',function(){
        window.location.href = "/sort/top10";
        $("body").addClass("loading");
    });

    $('.btn-danger,.btn-info').bind('click',function(){
        window.location.href = "/sort/bottom10";
        $("body").addClass("loading");
    });

    $('.home a').bind('click', function(){
        $("body").addClass("loading");
    });

});