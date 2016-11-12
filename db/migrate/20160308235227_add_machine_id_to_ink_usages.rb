class AddMachineIdToInkUsages < ActiveRecord::Migration
  def change
    add_reference :ink_usages, :machine_part_number, index: true, foreign_key: true

    # migrate part numbers to machine part numbers table
    PartNumber.all.each do |part_number|
      PartNumber.where(name: part_number.name).each do |target|
        if MachinePartNumber.where(part_number_id: PartNumber.where(name: target.name).first.id, machine_id: target.machine_id).empty?
          MachinePartNumber.create(part_number_id: PartNumber.where(name: target.name).first.id, machine_id: target.machine_id)
        end
      end
    end

    # migrate part_number_id to machine_part_number_id in ink_usages table
    PartNumber.group(:name).count.keys.uniq.each do |name|
      PartNumber.where(name: name).each do |part_number|
        ink_usages = InkUsage.where(part_number_id: part_number.id)
        if !ink_usages.empty?
          ink_usages.each do |ink_usage|
            machine_part_number = MachinePartNumber.where(machine_id: part_number.machine_id, part_number_id: PartNumber.where(name: part_number.name).order(id: :asc).first.id).first
            ink_usage.update_attribute(:machine_part_number_id, machine_part_number.id)
          end
        end
      end
    end

    if InkUsage.where(machine_part_number_id: nil).empty?
      remove_reference :ink_usages, :part_number, index: true, foreign_key: true
      remove_reference :part_numbers, :machine, index: true, foreign_key: true
    end

    # Delete duplicate part numbers in part numbers table
    PartNumber.all.each do |part_number|
      part_number.destroy if MachinePartNumber.where(part_number_id: part_number.id).empty?
    end
  end
end
