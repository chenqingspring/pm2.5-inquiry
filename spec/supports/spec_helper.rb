ENV['RACK_ENV'] ||= 'test'

require 'rspec'
require 'env'

GEO_CODE_JSON_RESPONSE_BEIJING = '{
    "status":"OK",
    "result":{
        "location":{
            "lng":116.327159,
            "lat":39.990912
        },
        "formatted_address":"北京市海淀区中关村南一街7号平房-4号",
        "business":"中关村,北京大学,五道口",
        "addressComponent":{
            "city":"北京市",
            "district":"海淀区",
            "province":"北京市",
            "street":"中关村南一街",
            "street_number":"7号平房-4号"
        },
        "cityCode":131
    }
}'

GEO_CODE_JSON_RESPONSE_HHHT = '{
    "status":"OK",
    "result":{
        "location":{
            "lng":111.660435,
            "lat":40.824832
        },
        "formatted_address":"内蒙古自治区呼和浩特市回民区新华西街5号",
        "business":"通道街,光明路,环河街",
        "addressComponent":{
            "city":"呼和浩特市",
            "district":"回民区",
            "province":"内蒙古自治区",
            "street":"新华西街",
            "street_number":"5号"
        },
        "cityCode":321
    }
}'

INVALID_CITY_NAME_MESSAGE = '<xml>
     <ToUserName><![CDATA[toUser]]></ToUserName>
     <FromUserName><![CDATA[fromUser]]></FromUserName>
     <CreateTime>1348831860</CreateTime>
     <MsgType><![CDATA[text]]></MsgType>
     <Content><![CDATA[invalid]]></Content>
     <MsgId>1234567890123456</MsgId>
    </xml>'

VALID_CITY_NAME_MESSAGE = '<xml>
     <ToUserName><![CDATA[toUser]]></ToUserName>
     <FromUserName><![CDATA[fromUser]]></FromUserName>
     <CreateTime>1348831860</CreateTime>
     <MsgType><![CDATA[text]]></MsgType>
     <Content><![CDATA[xian]]></Content>
     <MsgId>1234567890123456</MsgId>
    </xml>'


LOCATION_MESSAGE = '<xml>
	 <ToUserName><![CDATA[toUser]]></ToUserName>
	 <FromUserName><![CDATA[fromUser]]></FromUserName>
	 <CreateTime>1351776360</CreateTime>
	 <MsgType><![CDATA[location]]></MsgType>
	 <Location_X>23.134521</Location_X>
	 <Location_Y>113.358803</Location_Y>
	 <Scale>20</Scale>
	 <Label><![CDATA[位置信息]]></Label>
	 <MsgId>1234567890123456</MsgId>
	</xml>'


FAKE_PARSED_JSON_XIAN_FROM_API = [
    {'aqi'=>460,
     'area'=>'西安',
     'co'=>2.169,
     'co_24h'=>2.257,
     'no2'=>63,
     'no2_24h'=>49,
     'o3'=>24,
     'o3_24h'=>56,
     'o3_8h'=>24,
     'o3_8h_24h'=>56,
     'pm10'=>560,
     'pm10_24h'=>268,
     'pm2_5'=>84,
     'pm2_5_24h'=>68,
     'position_name'=>'高压开关厂',
     'primary_pollutant'=>'颗粒物(PM10)',
     'quality'=>'严重污染',
     'so2'=>27,
     'so2_24h'=>28,
     'station_code'=>'1462A',
     'time_point'=>'2014-03-28T19:00:00Z'}
]

FAKE_PARSED_JSON_GZ_FROM_API = [
    {'aqi'=>460,
     'area'=>'广州',
     'co'=>2.169,
     'co_24h'=>2.257,
     'no2'=>63,
     'no2_24h'=>49,
     'o3'=>24,
     'o3_24h'=>56,
     'o3_8h'=>24,
     'o3_8h_24h'=>56,
     'pm10'=>560,
     'pm10_24h'=>268,
     'pm2_5'=>84,
     'pm2_5_24h'=>68,
     'position_name'=>'监测点',
     'primary_pollutant'=>'颗粒物(PM10)',
     'quality'=>'严重污染',
     'so2'=>27,
     'so2_24h'=>28,
     'station_code'=>'1462A',
     'time_point'=>'2014-03-28T19:00:00Z'}
]