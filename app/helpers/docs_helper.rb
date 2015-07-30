module DocsHelper
  def generate_tag_list(tags)
    @doc.tags.any? ?
      @doc.tags.map {|tag| link_to(tag, docs_path(tag: tag)) }.join(",") 
      : "<em>(none)</em>"
  end    

  def excerpt_from(html, link_url)
    html = "<em>(blank)</em>" unless html.present?
    truncate_html(html, length: 250, omission: "...")
  end
end
