class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :name, unique: true, index: true

      t.timestamps null: false
    end
  end
end
