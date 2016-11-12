json.set! :highcharts do
  case @chart_type
  when :pie
    json.partial! partial: 'ink_usage_dashboards/pie_chart', locals: { machine: @machine, color_quantity: @color_quantity, chart_title: t(:ink_usage_chart_title, machine: @machine.name), total_quantity: @total_quantity, date_range_quantity: @date_range_quantity }
  when :column
    json.partial! partial: 'ink_usage_dashboards/column_chart', locals: { machine: @machine, color_quantity: @color_quantity, chart_title: t(:ink_usage_chart_title, machine: @machine.name) }
  end
end

json.table render partial: 'ink_usage_dashboards/ink_usage_summary.html.erb', locals: { machine: @machine, color_quantity: @color_quantity, chart_title: t(:ink_usage_chart_title, machine: @machine.name), total_quantity: @total_quantity, date_range_quantity: @date_range_quantity, dashboard_params: params[:dashboards] }
