class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters do |t|
      t.string :patient_name
      t.string :doctor_name
      t.integer :bill_id

      t.timestamps null: false
    end
  end
end
