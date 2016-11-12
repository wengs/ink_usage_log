module ApplicationHelper
  def format_date_time(timestamp)
    return timestamp if timestamp.is_a?(String)
    timestamp.strftime('%m/%d/%Y %I:%M %p')
  end

  def only_display_date(timestamp)
    return timestamp if timestamp.is_a?(String)
    timestamp.strftime('%m/%d/%Y')
  end

  def only_display_time(timestamp)
    return timestamp if timestamp.is_a?(String)
    timestamp.strftime('%I:%M %p')
  end

  def ink_usage_form_users_collection
     User.for_form_selection.order(name: :asc).map { |user| [user.name, user.id] }
  end
end
