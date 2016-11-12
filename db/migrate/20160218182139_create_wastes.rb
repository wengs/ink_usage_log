class CreateWastes < ActiveRecord::Migration
  def change
    create_table :wastes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :machine, index: true, foreign_key: true
      t.integer :level
      t.timestamps null: false
    end
  end
end
