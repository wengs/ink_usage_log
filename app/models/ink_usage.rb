class InkUsage < ActiveRecord::Base
  SUMMARY_HEADERS = ["Color - Part Number", "Quantity", "Date Range Percentage", "Total Percentage"]

  belongs_to :user
  belongs_to :machine_part_number
  delegate :part_number, to: :machine_part_number # Delegate exposes part_number from machine_part_number
  delegate :machine, to: :machine_part_number

  validates :part_number, :lot_number, :user, presence: true

  scope :exp_code_since, lambda { |date|
    where( 'exp_code >= ?', date )
  }

  scope :created_on, lambda { |date|
    where(created_at: date.beginning_of_day..date.end_of_day)
  }

  scope :for_machine, lambda { |machine|
    joins(:machine_part_number).
    where(machine_part_numbers: { machine_id: machine.id })
  }

  scope :created_between, lambda { |start_date, end_date|
    where(created_at: start_date.beginning_of_day..end_date.end_of_day)
  }

  def as_json(options={})
    super(only: [:id, :created_at, :lot_number, :exp_code],
      include: {
        part_number: {
          only: [:number],
          include: {color: { only: [:name] }}
        },
        machine: { only: [:name] },
        user: { only: [:name] }
      }
    )
  end

  def self.group_by_part_number
    self.group(:part_number_id)
  end

  private
  def self.ransackable_scopes(auth_object = nil)
    %i(exp_code_since created_on create_between)
  end
end
