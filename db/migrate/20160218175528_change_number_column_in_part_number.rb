class ChangeNumberColumnInPartNumber < ActiveRecord::Migration
  def change
    change_column :part_numbers, :number, :string
  end
end
