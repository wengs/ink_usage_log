class Waste < ActiveRecord::Base
  LEVELS = (1..5).to_a
  SUMMARY_HEADERS = ["Level", "Quantity", "Date Range Percentage", "Total Percentage"]

  belongs_to :user
  belongs_to :machine

  validates :user, :machine, :level, presence: true

  scope :created_on, lambda { |date|
    where(created_at: date.beginning_of_day..date.end_of_day)
  }

  scope :for_machine, lambda { |machine|
    where(machine_id: machine.id)
  }

  scope :created_between, lambda { |start_date, end_date|
    where(created_at: start_date.beginning_of_day..end_date.end_of_day)
  }

  def self.group_by_level
    self.group(:level)
  end

  private
  def self.ransackable_scopes(auth_object = nil)  # Make a scope/ class method to a ransackable scope
    %i(created_on created_between)
  end
end
