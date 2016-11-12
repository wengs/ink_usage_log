json.set! :machine_part_numbers do
  json.array! @machine_part_numbers do |machine_part_number|
    json.id machine_part_number.id
    json.number machine_part_number.part_number.number
    json.color machine_part_number.part_number.color ? machine_part_number.part_number.color.name : "No Color"
  end
end