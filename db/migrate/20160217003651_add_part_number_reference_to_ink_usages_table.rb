class AddPartNumberReferenceToInkUsagesTable < ActiveRecord::Migration
  def change
    add_reference :ink_usages, :part_number, index: true, foreign_key: true
  end
end
