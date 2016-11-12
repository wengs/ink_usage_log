class DashboardCSVExportsGenerator

  def initialize(options = {})
    @headers = options.fetch(:headers, "")
    @machine = options.fetch(:machine, "")
    @date_range_quantity = options.fetch(:date_range_quantity, "")
    @category_quantity = options.fetch(:category_quantity, "")
    @total_quantity = options.fetch(:total_quantity, "")
    @start_date = options.fetch(:start_date, "")
    @end_date = options.fetch(:end_date, "")
  end

  def generate
    CSV.generate do |csv|
      header_row(csv)
      body_rows(csv)
    end
  end

  def header_row(csv)
    csv << ["Machine", @machine.name]
    csv << ["Start Date", @start_date]
    csv << ["End Date", @end_date]
    csv << @headers
  end

  def body_rows(csv)
    @category_quantity.each do |category, quantity|
      csv << [category, quantity, percentage(quantity, @date_range_quantity), percentage(quantity, @total_quantity)]
    end
    csv << ['Total', @date_range_quantity, '100 %', percentage(@date_range_quantity, @total_quantity)]
  end

  private
  def percentage(numerator, denominator)
    sprintf("%.2f", numerator.to_f * 100/ denominator.to_f) + " %"
  end
end