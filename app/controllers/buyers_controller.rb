class BuyersController < ApplicationController

  require 'payjp'#Payjpの読み込み
  before_action :set_card, :set_item


  def index  #@card→card.newした内容
    if @card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      #カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    Payjp::Charge.create(
      amount: @item.price, #支払金額を引っ張ってくる
      customer: @card.customer_id,  #顧客ID
      currency: 'jpy',              #日本円
    )
    @item.buyer = current_user.id
    if @item.save
      redirect_to complete_item_buyers_path #完了画面に移動
    else
      flash[:error_message] = "購入に失敗しました"
      render "index"
    end  
  end

  def complete
  end

  private

  def set_card #カードの情報を取ってくる
    @card = Card.find_by(user_id: current_user.id)
  end

  def set_item #itemの情報を取ってくる
    @item = Item.find(params[:item_id])
  end

end
