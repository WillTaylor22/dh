module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.downcase
    direction = "desc" if column == sort_column && sort_direction == 'asc'
    css_class = column == sort_column ? "current_#{sort_direction}" : nil
    if direction
      link_to title.titlecase, { sort: column, direction: direction }, {class: css_class}
    else
      link_to title.titlecase, { sort: column} , { class: css_class }
    end
  end

end
