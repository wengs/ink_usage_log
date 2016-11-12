class Machine < ActiveRecord::Base
  has_many :machine_part_numbers, dependent: :destroy
  has_many :part_numbers, through: :machine_part_numbers
  accepts_nested_attributes_for :machine_part_numbers, allow_destroy: true

  has_many :colors, through: :part_numbers
  has_many :ink_usages, through: :part_numbers

  has_many :wastes

  validates :name, uniqueness: true
end
