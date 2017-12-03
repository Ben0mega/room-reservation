require 'rails_helper'

RSpec.describe Building, type: :model do
  describe 'Given a building name that exists' do
    it 'returns coords if it exists in database' do
      fake_building = Building.new
      lat = 123.456
      lng = 789.101
      ret = {lat: lat, lng: lng}
      allow(fake_building).to receive(:lat).and_return(lat)
      allow(fake_building).to receive(:lng).and_return(lng)
      expect(fake_building.geo).to eq(ret)
    end
    
    it 'query coords if it does not exist in database' do
      fake_building = Building.new
      allow(fake_building).to receive(:lat).and_return(nil)
      expect(fake_building).to receive(:query_gmap)
      fake_building.geo
    end
    
    it 'returns queried coords if it does not exist in database' do
      fake_building = Building.new
      lat = 123.456
      lng = 789.101
      ret = {'lat' => lat, 'lng' => lng}
      allow(fake_building).to receive(:lat).and_return(nil)
      payload = {status: 'OK', results: [geometry: {location: {lat: lat, lng: lng}}]}
      res = double(:body => payload.to_json)
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(res)
      expect(fake_building.geo).to eq(ret)
    end
  end
  
  describe 'Given a building name that does not exist' do
    it 'returns "Error" after query failed' do
      fake_building = Building.new
      payload = {status: 'ZERO_RESULTS', results: []}
      res = double(:body => payload.to_json)
      allow(fake_building).to receive(:lat).and_return(nil)
      allow_any_instance_of(Net::HTTP).to receive(:request).and_return(res)
      expect(fake_building.geo).to eq('Error')
    end
  end
end
