require 'rails_helper'

RSpec.describe Api::ListsController, type: :controller do
    describe 'POST #create' do
        context 'without authentication' do
            it 'has an http status response of unauthorised' do
                create(:user) #dont authenticate with this user
                post :create, params: {list: {name: "mylist", private: false}, user_id: User.first.id}
                expect(response).to have_http_status(401)
            end
        end

        context 'with authentication' do
            before do
                create(:user)
                request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("SamiB","password")
            end

            it 'assigns the correct params to the object' do
                post :create, params: {list: {name: "mylist", private: false}, user_id: User.first.id}
                expect(assigns(:list).name).to eq("mylist")
                expect(assigns(:list).private).to eq(false)
                expect(assigns(:list).user_id).to eq(User.first.id)
            end

            it 'saves the object to DB increasing size by 1' do
                expect {post :create, params: {list: {name: "mylist", private: false}, user_id: User.first.id}}.to change{List.all.count}.by(1)   
            end

            it 'returns the newly created list' do
                post :create, params: {list: {name: "mylist", private: false}, user_id: User.first.id}
                json = JSON.parse(response.body)
                expect(json["name"]).to eq("mylist")
                expect(json["user_id"]).to be_nil #the serializer shouldn't return the user_id associated with the list
            end
            it 'returns errors if object data not valid' do
                post :create, params: {list: {name: "", private: ""}, user_id: User.first.id}
                expect(response).to have_http_status(422)
            end
        end
      
    end
end
