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

    describe 'DELETE #destroy' do
        context 'without authentication' do
            it 'has an http status response of unauthorised' do
                create(:list)
                delete :destroy, params: {user_id: User.first.id, id: List.first.id}
                expect(response).to have_http_status(401)
            end
        end
        context 'with authentication' do
            before do
                create(:list)
                request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("SamiB","password")
            end
            it 'assigns the correct list to @list to delete' do
                delete :destroy, params: {user_id: User.first.id, id: List.first.id}
                expect(assigns(:list).name).to eq("The Sunday List") 
            end
            it 'deletes that list from the databse' do
                delete :destroy, params: {user_id: User.first.id, id: List.first.id}
                expect(List.first).to be_nil
            end
            it 'returns json success' do
                delete :destroy, params: {user_id: User.first.id, id: List.first.id}
                expect(response).to have_http_status(200)
            end
            it '404 not found if list does not exist' do
                delete :destroy, params: {user_id: User.first.id, id: 2}
                expect(response).to have_http_status(404)
            end
        end
    end

    describe 'PUT #update' do
        context 'without authentication' do
            it 'returns 401 error' do
                create(:list)
                put :update, params: {user_id: 1, id: 1, list: {name: "The Monday List", private: true}}
                expect(response).to have_http_status(401)    
            end
        end
        context 'with authentication' do
            before do
                create(:list)
                request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("SamiB","password")
            end
            it 'assigns new values to the object and retrieves the correct list object' do
                put :update, params: {user_id: 1, id: 1, list: {name: "The Monday List", private: true}}
                expect(assigns(:list).name).to eq("The Monday List")
                expect(assigns(:list).id).to eq(1)
            end
            it 'updates the object in the database' do
                put :update, params: {user_id: 1, id: 1, list: {name: "The Monday List", private: true}}
                expect(List.first.name).to eq("The Monday List")
            end
            it 'returns new updated object' do
                put :update, params: {user_id: 1, id: 1, list: {name: "The Monday List", private: true}}
                json = JSON.parse(response.body)
                expect(json["name"]).to eq("The Monday List")
                expect(json["user_id"]).to be_nil
            end
            it 'returns errors if data recieved invalid' do
                put :update, params: {user_id: 1, id: 1, list: {name: "", private: ""}}
                expect(response).to have_http_status(422)
            end
        end
    end
end
