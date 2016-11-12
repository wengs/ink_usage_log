module DashboardsHelper
  def chart_width_class(chart_type)
    case chart_type
    when :pie
      "col-xs-12"
    when :column
      "col-xs-12"
    else
      "col-xs-12"
    end
  end

  def chart_type_icon(chart_type)
    case chart_type
    when :pie
      "fa-pie-chart"
    when :column
      "fa-bar-chart"
    else
      "fa-pie-chart"
    end
  end
end
