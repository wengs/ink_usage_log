class AddNameColumnToPartNumbers < ActiveRecord::Migration
  def change
    add_column :part_numbers, :name, :string
  end
end
