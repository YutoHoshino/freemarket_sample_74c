class ItemsController < ApplicationController
  def index
    @items = Item.limit(10).order('created_at DESC')
    @parents = Category.where(ancestry: nil)
  end

  def show
    @items=Item.all.includes(:item_images).order('created_at DESC')
    @url = request.url
  end

  def new
    @item = Item.new
    @parents = Category.where(ancestry: nil)
    @item.item_images.build
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to root_path
  end

  def edit
    # @items = Item.find(params[:id])
    # @items.save
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :area_id, :categorys_id, :condition_id, :delivery_charge_id, :delivery_day_id, item_images_attributes: [:image])
  end
end
