module ApplicationHelper
  def icon c
    "<i class='fa #{c}'></i>".html_safe
  end
end
