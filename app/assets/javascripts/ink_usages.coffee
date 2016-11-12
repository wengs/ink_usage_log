$ ->
  $('select#Machine').change (e) ->
    $('select#ink_usage_part_number_id').empty();
    machine_id = $($(e.target).find(':selected')).val();
    if machine_id > 0
      link = '/machines/' + machine_id + '/machine_part_numbers.json'
      $.get link, (data) ->
        $.each data.machine_part_numbers, (index, value) ->
          $('select#ink_usage_machine_part_number_id').append($("<option></option>")
           .attr("value", value.id)
           .text(value.color + ' - ' + value.number));
    return

  $('thead.search-filter').change (e) ->
    $($(e.target).closest('form')).submit()
    return
  return