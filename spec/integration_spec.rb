require_relative '../spec/spec_helper'
require_relative '../app/app'

describe 'integration test' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'should return text message when weChat server request an invalid city name' do

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', INVALID_CITY_NAME_MESSAGE, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<Content><![CDATA[抱歉！暂未提供该城市pm2.5数据！]]></Content>'
  end

  it 'should return text image message when weChat server request an valid city name as xian' do

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', VALID_CITY_NAME_MESSAGE_XIAN, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<Title><![CDATA[查询城市:西安]]></Title>'
  end

  it 'should return text image message when weChat server request an valid location x=23.134521, y=113.358803 in 广州' do

    post '/weixin?signature=3b3d0829a84ba658a1ed72c9f90740e1ff88c797&timestamp=1388674716&nonce=1388564676', LOCATION_MESSAGE, 'CONTENT_TYPE' => 'text/xml'

    last_response.body.should include '<Title><![CDATA[查询城市:广州]]></Title>'
  end

end