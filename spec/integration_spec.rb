require_relative '../spec/supports/spec_helper'
require_relative '../spec/supports/rack_runner'
require_relative '../app/app'

describe 'integration test with 3rd party APIs' do
  it 'should return text message when weChat server request an invalid city name' do

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', INVALID_CITY_NAME_MESSAGE, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<ToUserName><![CDATA[fromUser]]></ToUserName>'
    last_response.body.should include '<Content><![CDATA[抱歉！暂未提供该城市pm2.5数据！]]></Content>'
  end

  it 'should return text image message when weChat server request an valid city name as xian' do

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', VALID_CITY_NAME_MESSAGE, 'CONTENT_TYPE' => 'text/xml'


    last_response.body.should include '<ToUserName><![CDATA[fromUser]]></ToUserName>'
    last_response.body.should include '<Title><![CDATA[查询城市:西安]]></Title>'
    last_response.body.should include '<Url><![CDATA[http://localhost:9393/redirect/%E8%A5%BF%E5%AE%89]]></Url>'
  end

  it 'should return text image message when weChat server request an valid location x=23.134521, y=113.358803 in 广州' do

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', LOCATION_MESSAGE, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<ToUserName><![CDATA[fromUser]]></ToUserName>'
    last_response.body.should include '<Title><![CDATA[查询城市:广州]]></Title>'
    last_response.body.should include '<Url><![CDATA[http://localhost:9393/redirect/%E5%B9%BF%E5%B7%9E]]></Url>'
  end

  it 'should return text image message when weChat server request an invalid city name with suffix and prefix space' do

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', INVALID_CITY_NAME_WITH_WHITE_SPACE_MESSAGE, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<ToUserName><![CDATA[fromUser]]></ToUserName>'
    last_response.body.should include '<Title><![CDATA[查询城市:西安]]></Title>'
    last_response.body.should include '<Url><![CDATA[http://localhost:9393/redirect/%E8%A5%BF%E5%AE%89]]></Url>'
  end

end