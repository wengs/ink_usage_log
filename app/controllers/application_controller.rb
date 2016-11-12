class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin_user!
    authenticate_user!
    unless current_user.superadmin
      flash[:error] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  def authenticate_io_admin_user!
    authenticate_user!
    unless current_user.io_admin
      flash[:error] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)

    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: true
    end
  end

  def concat_date_params(mm,dd,yyyy)
    mm.to_s + '/' + dd.to_s + '/' + yyyy.to_s
  end

  def format_string_to_date(date_string) #mm/dd/yyyy
    m, d, y = date_string.split '/'
    if ![y.to_i, m.to_i, d.to_i].any? {|n| n == 0} && Date.valid_date?(y.to_i, m.to_i, d.to_i)
      Date.strptime(date_string, "%m/%d/%Y")
    else
      nil
    end
  end
end
