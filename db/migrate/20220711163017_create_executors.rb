class CreateExecutors < ActiveRecord::Migration[6.1]
  def change
    create_table :executors do |t|
      t.string :name
      t.references :service, foreign_key: true

      t.timestamps
    end
  end
end
