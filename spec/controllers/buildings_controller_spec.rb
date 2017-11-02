require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do
  
  describe "shows the details page for the building" do
    before :each do 
      @id = "42"
      @user_id = "512"
      @fake_building = double('Fake Building')
      allow_any_instance_of(BuildingsController).to receive(:session_helper_user_id).and_return(@user_id)
      allow(Building).to receive(:find_by_id).with(@id).and_return(@fake_building)
      allow(@fake_building).to receive(:blank?).and_return(false)
      @room1  = double('Room1')
      @fake_rooms = [@room1]
      allow(Room).to receive(:where).and_return(@fake_rooms)
      allow(@room1).to receive(:misc).and_return("Misc")
      allow(@room1).to receive(:facilities).and_return("Facilities")
    end
    
    it 'searches the database for the building id' do
        expect(Building).to receive(:find_by_id).with(@id).and_return(@fake_building)
        get :show, {:id => @id}
    end
    
    it 'selects the Show Details page template' do
      get :show, {:id => @id}
      expect(response).to render_template('show')
    end
    
    it 'flashes an error message on the homepage if building does not exist' do
      allow(Building).to receive(:find_by_id).with(@id).and_return(nil)
      get :show, {:id => @id}
      expect(flash[:notice]).to be_present
      expect(response).to redirect_to(buildings_path)
    end
    
    it 'searches the database for rooms when valid search' do
      expect(Room).to receive(:where).with(:building_id => @id).and_return(@fake_rooms)
      get :show, {:id => @id}
    end  
    
    it 'sets the instance of rooms after a valid search' do
      get :show, {:id => @id}
      expect(assigns[:rooms]).to eq(@fake_rooms)
    end
    
    it 'assigns correct text when missing attributes of rooms' do
      allow(@room1).to receive(:misc).and_return(nil)
      allow(@room1).to receive(:facilities).and_return(nil)
      expect(@room1).to receive(:misc=)
      expect(@room1).to receive(:facilities=)
      get :show, {:id => @id}
    end
  end
  
  describe "checks for user login status" do
    before :each do
      @id = "42"
    end  
      
    it 'uses the helper function to check login status' do
      expect_any_instance_of(BuildingsController).to receive(:session_helper_user_id).and_return(@id)
      get :show, {:id => @id}
    end
    
    it 'redirects to home page with error message when not logged in' do
      get :show, {:id => @id}
      expect(flash[:notice]).to be_present
      expect(response).to redirect_to(buildings_path)
    end  
      
  end

end
