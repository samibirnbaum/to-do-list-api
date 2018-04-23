class Api::ItemsController < ApiController
    before_action :authenticated?

    def create
        @item = Item.new
        @item.name = params["item"]["name"]
        @item.complete = params["item"]["complete"]
        @item.list_id = params["list_id"]

        if @item.save
            render json: @item
        else
            render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
        end
    end
end
