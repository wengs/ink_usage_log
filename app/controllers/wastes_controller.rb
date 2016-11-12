class WastesController < ApplicationController
  before_action :authenticate_user_from_token!, :authenticate_user!
  before_action :authenticate_io_admin_user!, only: [:index]

  def index
    @q = Waste.ransack(params[:q] && convert_date_time_search_fields? ? params[:q] : "")
    @wastes = @q.result
    search_date_range
    @wastes = @wastes.order(created_at: :desc).page(params[:page]).per(50)
  end

  def new
    @waste = Waste.new
  end

  def create
    @waste = Waste.create(waste_params)

    if @waste.errors.empty?
      redirect_to current_user.io_admin ? wastes_path : new_waste_path
    else
      render :new
    end
  end

  private
  def convert_date_time_search_fields?
    return true if params[:q][:created_on].to_s.empty?
    converted = true
    if params[:q] && !params[:q][:created_on].empty?
      if format_string_to_date(params[:q][:created_on])
        params[:q][:created_on] = format_string_to_date(params[:q][:created_on])
      else
        converted = false
        flash[:error] = "Cannot search on Date. Please check your input format."
      end
    end
    converted
  end

  def waste_params
    params.require(:waste).permit(
      :user_id,
      :level,
      :machine_id
    )
  end

  def search_date_range
    if params[:start_date] && params[:end_date]
      @wastes = @wastes.created_between(Date.strptime(params[:start_date]),Date.strptime(params[:end_date]))
    end
  end
end
