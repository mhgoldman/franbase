module DocsHelper
  def excerpt_from(text, link_url)
    truncate(strip_tags(text), length: 250, escape: false, separator: ' ')
  end
end
