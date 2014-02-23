$('button.btn.btn-default').bind('click',function(){
    searchByName()
});

$('body').keypress(function(event){
    var code = event.keyCode || event.which;

    if(code == 13) {
        searchByName();
    }
});

function searchByName() {
    var cityName = encodeURI($('input.form-control').val());
    if (!cityName) {
        cityName = 'xian'
    }
    window.location.href = "/zones/" + cityName;
    $("body").addClass("loading");
}
