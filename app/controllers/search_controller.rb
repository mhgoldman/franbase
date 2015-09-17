class SearchController < ApplicationController
  def index
    q = params[:q]

    @tags = TagFinder.find(q: q).results
    @docs = DocFinder.find(q: q).results

    render json: {tags: @tags, docs: @docs, q: q}
  end
end