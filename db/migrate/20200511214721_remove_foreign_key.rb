class RemoveForeignKey < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :trips, :passengers
  end
end
