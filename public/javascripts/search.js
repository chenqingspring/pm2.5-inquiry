$('button.btn.btn-default').bind('click',function(){
    cityName = encodeURI($('input.form-control').val());
    window.location.href = "/zones/" + cityName;
    $("body").addClass("loading");
});

$('body').keyup(function(event){
    var code = event.keyCode || event.which,
        cityName = encodeURI($('input.form-control').val());
    if(code == 13) {
        if (!cityName){
            cityName = 'xian'
        }
        window.location.href = "/zones/" + cityName;
        $("body").addClass("loading");
    }
});