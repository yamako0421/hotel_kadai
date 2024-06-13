class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.date :check_in_date
      t.date :check_out_date
      t.string :total_nights
      t.integer :num_of_guests
      t.integer :total_amount

      t.timestamps
    end
  end
end
