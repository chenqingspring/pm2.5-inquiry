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


    if ('AV' in window) {
        var appId = 'PmV1nY70lW7jOSgdaz77Ek4x-gzGzoHsz';
        var appKey = 'y73IcLAkxJznpDxczxmA9sak';

        var analytics = AV.analytics({
            appId: appId,
            appKey: appKey,
            version: '1.8.6',
            channel: 'weixin'
        }).send([], function(result) {
            if (result) {
                console.log('统计数据发送成功！');
            }
        });
    }
});