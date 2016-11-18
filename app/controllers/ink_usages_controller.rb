class InkUsagesController < ApplicationController
  before_action :authenticate_user_from_token!, :authenticate_user!
  before_action :authenticate_io_admin_user!, only: [:index]

  def index
    @q =  InkUsage.ransack(params[:q] && convert_date_time_search_fields? ? params[:q] : "")
    @ink_usages = @q.result
    search_date_range
    @ink_usages = @ink_usages.order(created_at: :desc).page(params[:page]).per(50)

    respond_to do |format|
      format.html
      format.json { render json: @ink_usages.as_json }
    end
  end

  def new
    @all_machines = Machine.order(:name)
    @ink_usage = InkUsage.new
  end

  def create
    @ink_usage = InkUsage.create(ink_usage_params)
    if @ink_usage.errors.empty?
      flash[:success] = "#{InkUsage.model_name.human} was added!"
      redirect_to current_user.io_admin ? ink_usages_path : new_ink_usage_path
    else
      @all_machines = Machine.all
      render :new
    end
  end

  private
  def ink_usage_params
    params.require(:ink_usage).permit(
      :user_id,
      :machine_part_number_id,
      :lot_number,
      :exp_code
    )
  end

  def convert_date_time_search_fields?
    return true if params[:q][:created_on].to_s.empty? && params[:q][:exp_code_since].to_s.empty?
    converted = true
    if params[:q] && !params[:q][:created_on].empty?
      if format_string_to_date(params[:q][:created_on])
        params[:q][:created_on] = format_string_to_date(params[:q][:created_on])
      else
        converted = false
        flash[:error] = "Cannot search on Date. Please check your input format."
      end
    end

    if params[:q] && !params[:q][:exp_code_since].empty?
      if format_string_to_date(params[:q][:exp_code_since])
        params[:q][:exp_code_since] = format_string_to_date(params[:q][:exp_code_since])
      else
        converted = false
        flash[:error] = "Cannot search on #{InkUsage.human_attribute_name('exp_code')}. Please check your input format."
      end
    end
    converted
  end

  def search_date_range
    if params[:start_date] && params[:end_date]
      @ink_usages = @ink_usages.created_between(Date.strptime(params[:start_date]),Date.strptime(params[:end_date]))
    end
  end
end
