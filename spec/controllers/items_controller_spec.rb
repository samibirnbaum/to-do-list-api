require 'rails_helper'

RSpec.describe Api::ItemsController, type: :controller do
    describe 'POST #create' do
        context 'without authentication' do
            it 'responds with 401 unauthorized' do
                create(:list) #automatically creates user it belongs to in factory
                post :create, params: {item: {name: "myitem", complete: false}, list_id: List.first.id}
                expect(response).to have_http_status(401)
            end
        end
        context 'with authentication' do
            before do
                create(:list)
                request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("SamiB","password")
            end
            it 'assigns params to item object' do
                post :create, params: {item: {name: "myitem", complete: false}, list_id: List.first.id}
                expect(assigns(:item).name).to eq("myitem")
                expect(assigns(:item).complete).to eq(false)
                expect(assigns(:item).list_id).to eq(List.first.id)
            end
            it 'saves item and adds 1 to the DB' do
                expect {post :create, params: {item: {name: "myitem", complete: false}, list_id: List.first.id}}.to change{Item.all.count}.by(1)   

            end
            it 'returns saved item as json' do
                post :create, params: {item: {name: "myitem", complete: false}, list_id: List.first.id}
                json = JSON.parse(response.body)
                expect(json["name"]).to eq("myitem")
                expect(json["list_id"]).to be_nil
            end
            it 'returns error if params cant be processed' do
                post :create, params: {item: {name: "", complete: ""}, list_id: List.first.id}
                expect(response).to have_http_status(422)
            end
        end
    end

    describe 'PUT #update' do
        context 'without authentication' do
            it 'returns unathorised error' do
                create(:item)
                put :update, params: {item: {name: "updated item", complete: true}, list_id: 1, id: 1}
                expect(response).to have_http_status(401)
            end
        end
        context 'with authentication' do
            before do
                create(:item)
                request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("SamiB","password")
            end
            it 'assigns new data to retrieved item object' do
                put :update, params: {item: {name: "updated item", complete: true}, list_id: 1, id: 1}
                expect(assigns(:item).name).to eq("updated item")
                expect(assigns(:item).complete).to eq(true)
                expect(assigns(:item).id).to eq(1)
            end
            it 'updates item in the database' do
                put :update, params: {item: {name: "updated item", complete: true}, list_id: 1, id: 1}
                expect(Item.first.name).to eq("updated item")
            end
            it 'returns json of updated item' do
                put :update, params: {item: {name: "updated item", complete: true}, list_id: 1, id: 1}
                json = JSON.parse(response.body)
                expect(json["name"]).to eq("updated item")
                expect(json["list_id"]).to be_nil
            end
            it 'returns 422 if data invalid' do
                put :update, params: {item: {name: "", complete: ""}, list_id: 1, id: 1}
                expect(response).to have_http_status(422)
            end
        end
    end
end
