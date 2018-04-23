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
end
