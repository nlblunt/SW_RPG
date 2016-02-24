class ItemController < ApplicationController
    def index
        @items = Item.all
        
        render json: @items
    end
    
    def create
        #Create a new item
        i = Item.create(item_params)
        
        if i.valid?
            render json: {msg: "Item created"}
        else
            render status: :error, json: {e: "Error creating item"}
        end
    end
    
    private
    def item_params
        params.require(:item).permit(:name, :price, :description, :notes)
    end
end
