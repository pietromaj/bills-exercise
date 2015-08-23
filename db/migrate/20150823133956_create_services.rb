class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :cost
      t.integer :encounter_id

      t.timestamps null: false
    end
  end
end
