require_relative '../lib/geo_code_helper'
require_relative '../spec/spec_helper'

describe 'geo code helper' do
  it 'should return 北京 when get response with city name 北京市' do
    Pm25Inquiry::GeoCodeHelper.stub(:location_name){
      GEO_CODE_JSON_RESPONSE_BEIJING
    }

    city_name = Pm25Inquiry::GeoCodeHelper.geo_code_parser("123","321")
    city_name.should == '北京'
  end

  it 'should return the same name 呼和浩特 when get response with city name 呼和浩特' do
    Pm25Inquiry::GeoCodeHelper.stub(:location_name){
      GEO_CODE_JSON_RESPONSE_HHHT
    }

    city_name = Pm25Inquiry::GeoCodeHelper.geo_code_parser("123","321")
    city_name.should == '呼和浩特'
  end

end