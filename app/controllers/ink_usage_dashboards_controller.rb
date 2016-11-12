class InkUsageDashboardsController < ApplicationController
  before_action :authenticate_user_from_token!, :authenticate_io_admin_user!

  def index
    @machine = Machine.find(params[:dashboards][:machine])
    @chart_type = params[:dashboards][:chart_type].intern
    @end_date = format_string_to_date(concat_date_params(params[:dashboards]['end_date(2i)'], params[:dashboards]['end_date(3i)'], params[:dashboards]['end_date(1i)']))
    @start_date = format_string_to_date(concat_date_params(params[:dashboards]['start_date(2i)'], params[:dashboards]['start_date(3i)'], params[:dashboards]['start_date(1i)']))
    @ink_usages = InkUsage.for_machine(@machine).created_between(@start_date, @end_date)
    @date_range_quantity = @ink_usages.count
    @color_quantity = {}.tap do |hash|
      @ink_usages.group_by_part_number.count.each do |k,v|
        part_number = PartNumber.find(k)
        hash[part_number.color.name] = v
      end
    end
    @total_quantity = InkUsage.count
  end

  def download_csv
    self.index
    respond_to do |format|
      format.csv do
        @summary_exports_csv_generator = DashboardCSVExportsGenerator.new({
          headers: InkUsage::SUMMARY_HEADERS,
          machine: @machine,
          date_range_quantity: @date_range_quantity,
          category_quantity: @color_quantity,
          total_quantity: @total_quantity,
          start_date: @start_date,
          end_date: @end_date
        })
        headers['Content-Disposition'] = "attachment; filename='ink_usage_by_color_for_machine_#{@machine.name}_export.csv'"
        headers['Content-Type'] ||= 'text/csv'
        render text: @summary_exports_csv_generator.generate
      end
    end
  end
end
