$(document).ready(function(){
    var cityName = encodeURI($('.redirect').attr('data-src'));
    window.location.href = "/zones/" + cityName;
});