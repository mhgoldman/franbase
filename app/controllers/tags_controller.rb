class TagsController < ApplicationController
  def index
    tag_finder = TagFinder.find(params)

    @title = tag_finder.title
    @tags = tag_finder.results

    respond_to do |format|
      format.html
      format.json { 
        render json: @tags
      }
    end
  end
end
