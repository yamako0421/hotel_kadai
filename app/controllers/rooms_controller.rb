class RoomsController < ApplicationController

  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms # ログインしているユーザーが所有する施設のみ取得
    @reservation = Reservation.new
  end
  
  def show
    @room = Room.find(params[:id]) # 施設の詳細情報を取得する
    @reservation = Reservation.new
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
      if @room.save
        redirect_to :rooms
    else
      flash[:notice] = "施設登録されました."
      render :"new"
    end
  end
  
  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "施設情報を更新しました"
      redirect_to :rooms
    else
      flash[:notice_no_update] = "施設情報を更新できませんでした"
      render "edit"
    end
  end
  
  def destroy  
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "施設情報を削除しました"
    redirect_to :rooms
  end
  
  def search
    area = params[:area]
    keyword = params[:keyword]
  
    @rooms = Room.all


    if area.present?
      @rooms = Room.where("address LIKE ?", "%#{area}%")
    end
  
    if keyword.present?
      @rooms = Room.where("name LIKE ? OR description LIKE ?", "%#{keyword}%", "%#{keyword}%")
    end
  
  
    if @rooms.present?
      # 検索結果がある場合
      render 'search_results'
    else
      # 検索結果がない場合
      render 'no_search_results'
    end
 end

  
    private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image) # パラメータの許可とフィールドの指定
  end
end