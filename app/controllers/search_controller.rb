class SearchController < ApplicationController
  def index
    q = params[:q]

    @tags = Doc.all_tags.select {|t| t.include?(q) }
    @docs = DocFinder.find(q: q).results

    render json: {tags: @tags, docs: @docs, q: q}
  end
end
