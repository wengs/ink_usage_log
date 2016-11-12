$.each $(".highcharts"), (i, v) ->
  id = $(v).attr('id')
  tableId = $(v).data('table')
  $.get $(v).data('href'), (data) ->
    data.highcharts.chart['renderTo'] = id
    new Highcharts.Chart(data.highcharts)
    $(tableId).append(data.table)
