$(document).ready(function(){
    $('.btn-success, .btn-primary').bind('click',function(){
        window.location.href = "/sort/top10";
        $("body").addClass("loading");
    });

    $('.btn-danger,.btn-info').bind('click',function(){
        window.location.href = "/sort/bottom10";
        $("body").addClass("loading");
    });

    $('.adv.alert').bind('click',function(){
        window.location.href = "http://redirect.simba.taobao.com/rd?w=unionnojs&f=http%3A%2F%2Fre.taobao.com%2Feauction%3Fe%3DKNsCNmdtU4%252FebLdhAWchHFLwwtNwYCxu%252FgRj6p39QSeLltG5xFicOSZqewpHPyZzKnUjVbM4Ba5znfjY15mPXDUTFd7eF2DBT3yc3VnZj2iB3ujUJI0OeA%253D%253D%26ptype%3D100010&k=e2e107a2b72ca1b1&c=un&b=alimm_0&p=mm_52243835_5524728_17004310";
        $("body").addClass("loading");
    });

});