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

    // 应用 ID，用来识别应用
    var APP_ID = 'PmV1nY70lW7jOSgdaz77Ek4x-gzGzoHsz';

    // 应用 Key，用来校验权限（Web 端可以配置安全域名来保护数据安全）
    var APP_KEY = 'y73IcLAkxJznpDxczxmA9sak';

    // 初始化
    AV.init({
        appId: APP_ID,
        appKey: APP_KEY
    });

});