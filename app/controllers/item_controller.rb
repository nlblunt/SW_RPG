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
    
    def update
        #Update the item
        i = Item.find_by_id(params[:id])
        i.update(item_params)
        
        render json: {msg: "Item Updated"}
    end
    
    def destroy
        i = Item.find_by_id(params[:id])
        i.delete
        
        render json: {msg: "Item Deleted"}
    end
    
    private
    def item_params
        params.require(:item).permit(:name, :price, :description, :notes)
    end
end
