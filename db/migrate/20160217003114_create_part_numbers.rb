class CreatePartNumbers < ActiveRecord::Migration
  def change
    create_table :part_numbers do |t|
      t.integer :number
      t.references :color, index: true, foreign_key: true
      t.references :machine, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
