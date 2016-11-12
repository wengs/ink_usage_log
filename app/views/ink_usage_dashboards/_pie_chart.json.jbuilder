json.set! :exporting do
  json.enabled true
  json.filename chart_title
end

json.colors ['#BDD4DE', '#E57A10', '#F2481D', '#354873', '#A23645', '#81C4F1', '#4E4676', '#6AF9C4', "#007079", "#009BFF", "#F7E967", "#F27281", "#85DB2D"]

json.set! :chart do
  json.type 'pie'
end

json.set! :title do
  json.text chart_title
end

json.set! :tooltip do
  json.pointFormat '{series.name}: <b>{point.y}</b><br />Date Range Quantity: <b>{point.date_range_quantity}</b> <br />Total Quantity: <b>{point.total_quantity}</b> <br />Date Range Percentage: <b>{point.percentage:.2f} %</b><br /><br />Total Percentage: <b>{point.percentage_of_total:.2f} %</b> '
end

json.set! :plotOptions do
  json.set! :pie do
    json.allowPointSelect true
    json.cursor 'pointer'
    json.innerSize '50%'
    json.set! :dataLabels do
      json.enabled true
      json.format '<b>{point.name}</b> <br />Quantity: {point.y} <br />Date Range Percentage: {point.percentage:.2f}% <br /> Total Percentage: {point.percentage_of_total:.2f} %'
    end
  end
end

json.series [""] do |set|
  json.name 'Quantity'
  json.colorByPoint true
  json.data color_quantity do |key, value|
    json.name key
    json.y value
    json.date_range_quantity date_range_quantity
    json.total_quantity total_quantity
    json.percentage_of_total value.to_f * 100.00 / total_quantity.to_f
  end
end

json.set! :credits do
  json.enabled false
end
