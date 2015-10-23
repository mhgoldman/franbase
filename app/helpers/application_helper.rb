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
    (tags || []).map {|tag| tag_for(tag) }.join(" ") 
  end    

  def tag_for(text)
    "<span class='tag'><a href='/docs?tag=#{text}'>#{glyphicon_for(:tag,text)}</a></span>".html_safe
  end  

  def glyphicon_for(name,label)
    "<i class='glyphicon glyphicon-#{name}'></i>&nbsp;#{label}".html_safe
  end
end
