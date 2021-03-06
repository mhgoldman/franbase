class DocFinder

  attr_accessor :results, :criteria, :title

  def initialize(criteria)
    @criteria = criteria
    perform
  end

  def perform
    if criteria[:q].present?
      @results = Doc.search(criteria[:q])
      @title = "Doc Search Results for '#{criteria[:q]}'"
    elsif criteria[:tag].present?
      @results = Doc.where(tags: criteria[:tag])
      @title = "Docs Tagged '#{criteria[:tag]}'"
    else
      @results = Doc.all
      @title = "Docs"
    end
  end

  def self.find(params)
    criteria = params.slice(:q, :tag)
    DocFinder.new(criteria)
  end
end