module ApplicationHelper
  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-danger',
    notice: 'alert-info'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG[flash_type] || BOOTSTRAP_FLASH_MSG[flash_type.to_sym]
  end

  def tag_list_for(tags)
    tags.map {|tag| tag_for(tag) }.join(" ") 
  end    

  def tag_for(text)
    "<span class='tag'><a href='/docs?tag=#{text}'><i class='glyphicon glyphicon-tag'></i> #{text}</a></span>".html_safe
  end  
end
