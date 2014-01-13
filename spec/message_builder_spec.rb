require_relative '../lib/message_builder'
require_relative 'spec_helper'

describe 'message builder' do
  before(:each) do
    @fake_last_average_data = {
        'aqi' =>'103',
        'area' =>'西安',
        'pm2_5' =>'77',
        'pm2_5_24h' =>'121',
        'position_name' =>'null',
        'primary_pollutant' =>'颗粒物(PM2.5)',
        'quality' =>'轻度污染',
        'station_code' =>'null',
        'time_point' =>'2014-01-11T23:00:00Z'
    }
    @fake_update_time = '2014年1月12日19时2分'
  end

  it 'should return correct message when receive average city info data' do
    MessageBuilder.stub(:select_image){
      'http://selected_image_url'
    }

    result = MessageBuilder.text_image_message(@fake_last_average_data, @fake_update_time)[0]

    result[:title].should == '查询城市:西安'
    result[:description].should == "        pm2.5平均值:77\n\n污染等级:轻度污染\n\n发布时间:2014年1月12日19时2分"
    result[:picture_url].should == 'http://selected_image_url'
    result[:url].should == 'http://localhost:9393/zones/%E8%A5%BF%E5%AE%89'
  end
end