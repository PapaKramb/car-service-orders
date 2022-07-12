class AddServiceOrderReferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :service, null: false, foreign_key: true
  end
end
