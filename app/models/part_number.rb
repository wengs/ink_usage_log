class PartNumber < ActiveRecord::Base
  IMPORT_FILE_FORMATS = %w(.csv .xls .xlsx)
  belongs_to :color

  has_many :machine_part_numbers, dependent: :destroy
  has_many :machines, through: :machine_part_numbers
  accepts_nested_attributes_for :machine_part_numbers, allow_destroy: true

  has_many :ink_usages

  validates :name, :number, presence: true
  validates :name, :number, uniqueness: true

  scope :for_machine, lambda { |machine|
    where(machine_id: machine.id)
  }

  scope :for_color, lambda { |color|
    where(color_id: color.id)
  }

  def self.import(file, user)
    headers = file.row(1).map do |i|
      if ["machine", "machines", "machines names", "machine names"].include?(i.downcase)
        :machine_id
      elsif ["color","colors", "colors names", "Color names"].include?(i.downcase)
        :color_id
      else
        i
      end
    end
    return false if self.correct_headers(headers).empty?
    failed_rows = []
    (2..file.last_row).each do |i|
      row = Hash[[headers, file.row(i)].transpose]

      existed_part_number = !PartNumber.where(name: row["name"], number: row["number"]).empty? && PartNumber.where(name: row["name"], number: row["number"]).first
      existed_machine = Machine.find_by_name(row[:machine_id])
      existed_machine_part_number = existed_part_number && MachinePartNumber.where(part_number_id: existed_part_number.id, machine_id: existed_machine.id).first
      existed_color = Color.find_by_name(row[:color_id])

      # The machine does not exist, or the machine part number already exists, the import color does not match the part number fail right away
      if !existed_machine  || ( !existed_part_number && (existed_machine_part_number || !existed_color && existed_part_number.color != existed_color ))
        failed_rows << i
      elsif existed_part_number && existed_machine                  # part number and machine exist
        machine_part_number = MachinePartNumber.new
        machine_part_number.machine_id = existed_machine.id
        machine_part_number.part_number_id = existed_part_number.id
        failed_rows << i unless machine_part_number.save
      else                                                          # part number does not exist, need to create a new part number, then create machine_part_number
        part_number = self.new
        part_number.color = existed_color
        part_number.name = row["name"]
        part_number.number = row["number"]

        if part_number.save
          MachinePartNumber.create(part_number_id: part_number.id, machine_id: existed_machine.id)
        else
          failed_rows << i
        end
      end
    end
    failed_rows
  end

  private
  def self.correct_headers(headers)
    headers.select { |header| column_names.include?(header) }
  end

  def self.include_attributes?(k)
    [:id, :created_at, :updated_at].include?(k.intern)
  end

  def self.format_date_time_attributes(hash)
    {}.tap do |new_hash|
      hash.to_a.map { |k, v| new_hash[k] = self.columns_hash[k].type == :datetime ? Time.zone.parse(v) : v }
    end
  end
end
