class DashboardsController < ApplicationController
  CHART_TYPES = {
    pie: "Pie",
    column: "Column"
  }

  before_action :authenticate_user_from_token!, :authenticate_io_admin_user!

  def index
    verify_input; return if performed?
    @chart_type = params[:dashboards][:chart_type].intern
    @machine = Machine.find(params[:dashboards][:machine])
  end

  def new
    @chart_types = CHART_TYPES.invert
    @machines = Machine.order(name: :asc)
  end

  private
  def verify_input
    return if machine_chosen? && correct_date_range? && chart_type_chosen?
    flash[:error] = flash[:error].presence.to_s + "Please choose a Chart Type" unless chart_type_chosen?
    flash[:error] = "Please choose a Machine. " unless machine_chosen?
    flash[:error] = flash[:error].presence.to_s + "Invalid Date Range. " unless correct_date_range?
    redirect_to  new_dashboard_path(dashboards: params[:dashboards].presence) and return
  end

  def correct_date_range?
    return false unless params[:dashboards]
    end_date = format_string_to_date(concat_date_params(params[:dashboards]['end_date(2i)'], params[:dashboards]['end_date(3i)'], params[:dashboards]['end_date(1i)']))
    start_date = format_string_to_date(concat_date_params(params[:dashboards]['start_date(2i)'], params[:dashboards]['start_date(3i)'], params[:dashboards]['start_date(1i)']))
    end_date >= start_date
  end

  def machine_chosen?
    params[:dashboards] && !params[:dashboards][:machine].to_s.empty?
  end

  def chart_type_chosen?
    params[:dashboards] && !params[:dashboards][:chart_type].to_s.empty?
  end
end
