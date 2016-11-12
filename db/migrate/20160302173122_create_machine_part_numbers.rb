class CreateMachinePartNumbers < ActiveRecord::Migration
  def change
    create_table :machine_part_numbers do |t|
      t.references :machine, index: true, foreign_key: true
      t.references :part_number, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
