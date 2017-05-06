class AddStatusColumnToProducts < ActiveRecord::Migration
  def change
    add_column :products, :status, :string, :default => "available"
  end
end
