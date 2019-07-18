class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, except: %i[index new]
  # before_action :move_to_index, except: [:index, :show

  def index
    @items = Item.all.includes(:item_images).order("created_at DESC")
  end

  def show
    # find(1)は後でfind(params[:id])に修正する
    @item = Item.find(1)
    render layout: "layout_items_show"
  end

  def new
    render layout: "second_layout"
  end

  def edit; end

  def update
    redirect_to root_path unless @item.user.id == current_user.id
    if @item.update(update_item_params)
      redirect_to item_path(@item)
    else
      render redirect_to item_path(@itema)
    end
  end

  def destroy
    if current_user.id == @item.user_id
      if @item.destroy
        redirect_to root_path, flash: { success: '削除しました' }
      else
        redirect_to root_path, flash: { warning: '削除に失敗しました' }
      end
    end
  end

  def buy; end

  def pay
    require 'payjp'
    Payjp.api_key = 'sk_test_dee871c5b4611010f667e809'
    charge =Payjp::Charge.create(
      amount: @item.price,
      card: params['payjp-token'],
      currency: 'jpy'
    )
    @item.user.profit += @item.price
    @item.user.save
    redirect_to item_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def update_item_params
    params.require(:item).permit(:name,
                                :description,
                                :price,
                                item_image_attributes: %i[id url],
                                item_details_attributes: %i[id size brand condition])
  end
end
