class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(:room)
  end


  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(room: @room)
  end

 
  def create
    @reservation = current_user.reservations.build(reservation_params)
    @room = @reservation.room

    if @reservation.save
      @reservation.update(total_amount: calculate_total_amount(@reservation))
      redirect_to @reservation, notice: '予約が作成されました。'
    else
      @room = Room.find(@reservation.room_id)
      render 'rooms/show'
    end
  end


  def show
    @reservation = current_user.reservations.find(params[:id])
    @total_nights = (@reservation.check_out_date - @reservation.check_in_date).to_i
    @room = @reservation.room
    Rails.logger.debug "Reservation details: #{@reservation.inspect}"
    Rails.logger.debug "Total amount: #{@reservation.total_amount.class} - #{@reservation.total_amount}"
  end

  def update
    @reservation = current_user.reservations.find(params[:id])
    if @reservation.update(reservation_params)
      @reservation.update(total_amount: calculate_total_amount(@reservation))
      redirect_to reservations_path, notice: '予約が確定しました。'
    else
      render :show
    end
  end
  
  private

  
  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :num_of_guests, :room_id)
  end

  def calculate_total_amount(reservation)
    check_in_date = Date.parse(reservation.check_in_date.to_s)
    check_out_date = Date.parse(reservation.check_out_date.to_s)
    total_nights = (check_out_date - check_in_date).to_i
    total_nights * reservation.room.price * reservation.num_of_guests
  end
end