class ChangeTotalAmountToIntegerInReservations < ActiveRecord::Migration[6.1]
  def change
    change_column :reservations, :total_amount, :integer
  end
end
