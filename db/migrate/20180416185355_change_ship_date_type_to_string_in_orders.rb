class ChangeShipDateTypeToStringInOrders < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :ship_date, :string
  end
end
