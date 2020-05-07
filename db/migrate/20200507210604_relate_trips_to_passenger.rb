class RelateTripsToPassenger < ActiveRecord::Migration[6.0]
  def change
    remove_column :trips, :passenger_id
    add_reference :trips, :passenger, index: true, foreign_key: true
  end
end
