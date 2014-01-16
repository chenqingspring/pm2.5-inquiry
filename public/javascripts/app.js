$(document).ready(function(){
    $(".btn-success").bind('click',function(){
        window.location.href = "/top10";
    })

    $(".btn-danger").bind('click',function(){
        window.location.href = "/bottom10";
    })
});