json.set! :highcharts do
  case @chart_type
  when :pie
    json.partial! partial: 'waste_dashboards/pie_chart', locals: { machine: @machine, level_quantity: @level_quantity, chart_title: t(:waste_chart_title, machine: @machine.name), total_quantity: @total_quantity, date_range_quantity: @date_range_quantity }
  when :column
    json.partial! partial: 'waste_dashboards/column_chart', locals: { machine: @machine, level_quantity: @level_quantity, chart_title: t(:waste_chart_title, machine: @machine.name), total_quantity: @total_quantity, date_range_quantity: @date_range_quantity }
  end
end

json.table render partial: 'waste_dashboards/waste_summary.html.erb', locals: { machine: @machine, level_quantity: @level_quantity, chart_title: t(:waste_chart_title, machine: @machine.name), total_quantity: @total_quantity, date_range_quantity: @date_range_quantity, dashboard_params: params[:dashboards] }
