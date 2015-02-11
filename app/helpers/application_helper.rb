module ApplicationHelper

  def sortable(title, column)
    direction = params[:direction] # asc or desc
    sort = params[:sort] # distance or date

    if sort == nil && column == "distance"
      # no params? ascending if column == 'distance'
      css_class = "link-to-descending active"
    elsif sort == column && direction == 'asc'
      # params? 'descending' iff sort == column and direction == ascending
      css_class = "link-to-descending"
    else
      # most of the time, you want ascending
      css_class = "link-to-ascending"
    end
    css_class += " " + column
    css_class += " active" if sort == column

    content_tag 'a', title.titlecase, class: css_class
  end

  def select_me attribute, string
    'selected="selected"' if params[attribute] == string
  end

end
