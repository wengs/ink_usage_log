class AddSuperadminToUser < ActiveRecord::Migration
  def change
    add_column :users, :superadmin, :boolean, null: false, default: false
    add_column :users, :name, :string
  end
end
