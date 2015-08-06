module DocsHelper
  def generate_tag_list(tags)
    tags.any? ?
      tags.map {|tag| tag_for(tag) }.join(" ") 
      : "<em>(none)</em>"
  end    

  def tag_for(text)
    "<span class='tag'><a href='/docs?tag=#{text}'><i class='glyphicon glyphicon-tag'></i> #{text}</a></span>".html_safe
  end

  def excerpt_from(text, link_url)
    truncate(strip_tags(text), length: 250, escape: false, separator: ' ')
  end
end
