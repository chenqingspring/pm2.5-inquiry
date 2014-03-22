var cityName = encodeURI(document.getElementById('redirect').getAttribute('data-src'));
window.location.href = "/zones/" + cityName;
