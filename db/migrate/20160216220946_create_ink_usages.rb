class CreateInkUsages < ActiveRecord::Migration
  def change
    create_table :ink_usages do |t|
      t.string :lot_number, index: true
      t.date :exp_code, index: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
