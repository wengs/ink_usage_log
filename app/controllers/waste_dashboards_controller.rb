class WasteDashboardsController < ApplicationController
  before_action :authenticate_user_from_token!, :authenticate_io_admin_user!

  def index
    @machine = Machine.find(params[:dashboards][:machine])
    @chart_type = params[:dashboards][:chart_type].intern
    @end_date = format_string_to_date(concat_date_params(params[:dashboards]['end_date(2i)'], params[:dashboards]['end_date(3i)'], params[:dashboards]['end_date(1i)']))
    @start_date = format_string_to_date(concat_date_params(params[:dashboards]['start_date(2i)'], params[:dashboards]['start_date(3i)'], params[:dashboards]['start_date(1i)']))
    @wastes = Waste.for_machine(@machine).created_between(@start_date, @end_date)
    @date_range_quantity = @wastes.count
    @level_quantity = @wastes.group_by_level.count
    @total_quantity = Waste.count
  end

  def download_csv
    self.index
    respond_to do |format|
      format.csv do
        @summary_exports_csv_generator = DashboardCSVExportsGenerator.new({
          headers: Waste::SUMMARY_HEADERS,
          machine: @machine,
          date_range_quantity: @date_range_quantity,
          category_quantity: @level_quantity,
          total_quantity: @total_quantity,
          start_date: @start_date,
          end_date: @end_date
        })
        headers['Content-Disposition'] = "attachment; filename='waste_by_level_for_machine_#{@machine.name}_export.csv'"
        headers['Content-Type'] ||= 'text/csv'
        render text: @summary_exports_csv_generator.generate
      end
    end
  end
end
