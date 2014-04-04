$(document).ready(function(){
    $('.btn-success, .btn-primary').bind('click',function(){
        window.location.href = "/sort/top10";
        $("body").addClass("loading");
        $('.modal .center').text('正在计算排名，请稍后...');
    });

    $('.btn-danger,.btn-info').bind('click',function(){
        window.location.href = "/sort/bottom10";
        $("body").addClass("loading");
        $('.modal .center').text('正在计算排名，请稍后...');
    });

    $('.home a').bind('click', function(){
        $("body").addClass("loading");
    });

});