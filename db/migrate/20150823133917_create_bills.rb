class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :avg_cost

      t.timestamps null: false
    end
  end
end
