class AddPreparationTimeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :prep_time, :integer, :default => 12
  end
end
