module DocsHelper
  def generate_tag_list(tags)
    tags.any? ?
      tags.map {|tag| link_to(tag, docs_path(tag: tag)) }.join(",") 
      : "<em>(none)</em>"
  end    

  def excerpt_from(text, link_url)
    truncate(strip_tags(text), length: 250, escape: false, separator: ' ')
  end
end
