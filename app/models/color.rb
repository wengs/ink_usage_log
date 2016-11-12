class Color < ActiveRecord::Base
  has_many :part_numbers

  validates :name, presence:true, uniqueness: true
end
