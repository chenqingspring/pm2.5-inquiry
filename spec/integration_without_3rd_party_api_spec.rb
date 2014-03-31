require_relative '../spec/supports/spec_helper'
require_relative '../spec/supports/rack_runner'
require_relative '../app/app'

describe 'integration test without invoking 3rd party APIs' do
  it 'should return text message when weChat server request an invalid city name' do

    Pm25ApiHelper.stub(:parsed_json_builder){
      {'error' => '该城市还未有AQI详细数据数据'}
    }

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', VALID_CITY_NAME_MESSAGE, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<ToUserName><![CDATA[fromUser]]></ToUserName>'
    last_response.body.should include '<Content><![CDATA[抱歉！暂未提供该城市pm2.5数据！请发送城市名称(北京)或(beijing)或通过分享地理位置进行查询!]]></Content>'
  end

  it 'should return text image message when weChat server request an valid city name as xian' do

    Pm25ApiHelper.stub(:parsed_json_builder){
      FAKE_PARSED_JSON_XIAN_FROM_API
    }
    MessageBuilder.stub(:select_image){
      'http://selected_image_url'
    }

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', VALID_CITY_NAME_MESSAGE, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<ToUserName><![CDATA[fromUser]]></ToUserName>'
    last_response.body.should include '<FromUserName><![CDATA[toUser]]></FromUserName>'
    last_response.body.should include '<MsgType><![CDATA[news]]></MsgType>'
    last_response.body.should include '<Title><![CDATA[查询城市:西安]]></Title>'
    last_response.body.should include '<ArticleCount>1</ArticleCount>'
    last_response.body.should include 'PM2.5平均值: 84'
    last_response.body.should include '<PicUrl><![CDATA[http://selected_image_url]]></PicUrl>'
    last_response.body.should include '<Url><![CDATA[http://localhost:9393/redirect/%E8%A5%BF%E5%AE%89]]></Url>'
  end

  it 'should return text image message when weChat server request an valid location x=23.134521, y=113.358803 in 广州' do

    Pm25Inquiry::GeoCodeHelper.stub(:geo_code_parser){
      '广州'
    }
    Pm25ApiHelper.stub(:parsed_json_builder){
      FAKE_PARSED_JSON_GZ_FROM_API
    }

    MessageBuilder.stub(:select_image){
      'http://selected_image_url'
    }

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', LOCATION_MESSAGE, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<ToUserName><![CDATA[fromUser]]></ToUserName>'
    last_response.body.should include '<FromUserName><![CDATA[toUser]]></FromUserName>'
    last_response.body.should include '<MsgType><![CDATA[news]]></MsgType>'
    last_response.body.should include '<Title><![CDATA[查询城市:广州]]></Title>'
    last_response.body.should include '<ArticleCount>1</ArticleCount>'
    last_response.body.should include 'PM2.5平均值: 84'
    last_response.body.should include '<Url><![CDATA[http://localhost:9393/redirect/%E5%B9%BF%E5%B7%9E]]></Url>'
  end

end