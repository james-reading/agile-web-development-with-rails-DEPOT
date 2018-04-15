class ChangeShipDateTypeToString < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :ship_date, :strign
  end
end
