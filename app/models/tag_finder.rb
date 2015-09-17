class TagFinder

  attr_accessor :results, :criteria, :title

  def initialize(criteria)
    @criteria = criteria
    perform
  end

  def perform
    if criteria[:q].present?
      @results = Doc.all_tags.select {|t| t.include?(criteria[:q])}
      @title = "Tag Search Results for '#{criteria[:q]}'"
    else
      @results = Doc.all_tags
      @title = "Tags"
    end
  end

  def self.find(params)
    criteria = params.slice(:q)
    TagFinder.new(criteria)
  end
end