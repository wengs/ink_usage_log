json.set! :exporting do
  json.enabled true
  json.filename chart_title
end

json.colors ['#7FB239']

json.set! :chart do
  json.type 'column'
end

json.set! :title do
  json.text chart_title
end

json.set! :xAxis do
  json.categories color_quantity.keys
end

json.set! :yAxis do
  json.min 0
  json.set! :title do
    json.text 'Quantity'
  end
  json.endOnTick false
  json.maxPadding 0.1
end

json.set! :tooltip do
  json.pointFormat '{series.name}: <b>{point.y}</b><br />Date Range Quantity: <b>{point.date_range_quantity}</b> <br />Total Quantity: <b>{point.total_quantity}</b> <br />Date Range Percentage: <b>{point.percentage:.2f} %</b><br /><br />Total Percentage: <b>{point.percentage_of_total:.2f} %</b> '
end

json.set! :legend do
  json.enabled false
end

json.set! :plotOptions do
  json.set! :series do

  end
end

json.series [""] do |set|
  json.name 'Quantity'
  json.colorByPoint true
  json.data color_quantity.values
end

json.set! :credits do
  json.enabled false
end
