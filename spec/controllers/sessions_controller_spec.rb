require 'rails_helper'
RSpec.describe SessionsController, type: :controller do
    describe 'it handles logging it' do
        before :each do
            @fake_user = double('user')
            @id = "42"
            allow(@fake_user).to receive(:id).and_return(@id)
            allow(User).to receive(:from_omniauth).and_return(@fake_user)
            controller = SessionsController.new
            allow_any_instance_of(SessionsController).to receive(:redirect_helper).and_return(true)
        end
        
        it 'creates a new user' do
            expect(User).to receive(:from_omniauth)
            controller.create
        end 
        
        it 'sets the session hash with user id' do
            controller.create
            expect(session[:user_id]).to eq(@id)
        end    
        
        it 'clears the session hash when logging out' do
            session[:user_id] = @id
            controller.destroy
            expect(session[:user_id]).to eq(nil)
        end
            
    end
end