class ChangePayTypeInOrdersToString < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :pay_type, :string
  end
end
