ActiveAdmin.register Machine do
  permit_params :name, part_number_ids: []

  active_admin_import validate: true,
                      timestamps: true

  index do
    selectable_column
    id_column
    column :name
    column "Part Numbers" do |machine|
      machine.part_numbers.map(&:number).join(', ')
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :part_numbers do |object|
        object.part_numbers.map(&:name).join(', ')
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'Part Number Details' do
      f.input :name
      f.input :part_numbers, as: :check_boxes
    end
    f.actions
  end
end