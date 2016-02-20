module ApplicationHelper
  def icon c
    "<i class='fa #{c}'></i>".html_safe
  end

  def iconbutton(classname, id='') 
    "<i class='fa btn #{classname}' data-id='#{id}'></i>".html_safe
  end

end
