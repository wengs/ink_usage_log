class MachinePartNumber < ActiveRecord::Base
  belongs_to :machine
  belongs_to :part_number
end
