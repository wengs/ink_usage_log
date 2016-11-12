ActiveAdmin.register PartNumber do
  permit_params :number, :name, :color_id, machine_ids: []
  action_item :only => :index do
    link_to 'Import Part Numbers', action: "upload_part_numbers", method: :get
  end

  collection_action :upload_part_numbers, method: :get do   # see the view in views/admin/part_numbers/upload_part_numbers.html.erb
  end

  collection_action :import_part_numbers, :method => :post do
    spreadsheet = Roo::Spreadsheet.open(params[:part_numbers_imports][:file]) if params[:part_numbers_imports]

    if spreadsheet
      failed_rows = PartNumber.import(spreadsheet, current_user)
      if failed_rows == false
        flash[:error] = "Header in import file is incorrect."
      elsif failed_rows.empty?
        flash[:success] = "The file was imported successfully."
      else
        flash[:error] = "Rows #{failed_rows.join(", ")} are incorrect. Please correct the import file."
      end
    else
      flash[:notice] = "Unknown file type. Please upload a #{PartNumber::IMPORT_FILE_FORMATS.join('/ ')} file."
    end

    redirect_to action: :index
  end

  index do
    selectable_column
    id_column
    column :name
    column :number
    column :color
    column "Machines" do |part_number|
      part_number.machines.map(&:name).join(', ')
    end
    actions
  end

   show do
    attributes_table do
      row :name
      row :number
      row :color
      row :machines do |object|
        object.machines.map(&:name).join(', ')
      end
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs 'Part Number Details' do
      f.input :name
      f.input :number
      f.input :color
      f.input :machines, as: :check_boxes
    end
    f.actions
  end
end