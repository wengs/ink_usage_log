ActiveAdmin.register Color do
  permit_params :name

  active_admin_import validate: true,
                      timestamps: true,
                      batch_size: 1000

  index do
    selectable_column
    id_column
    column :name
    actions
  end
end