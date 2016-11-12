ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation, :role_id

  controller do
    def update
      # filter password if submitted as empty
      if params[:user][:password].empty? && params[:user][:password_confirmation].empty?
        params[:user].reject! { |key, _| %w(password password_confirmation).include? key.to_s }
      end
      super
    end
  end

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :role
      row :sign_in_count
      row :last_sign_in_ip
      row :failed_attempts
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs 'Admin Details' do
      f.input :name
      f.input :email
      f.input :role
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
