class TagsController < ApplicationController
  def index
    @tags = Doc.all_tags.select {|t| params[:q].present? ? t.include?(params[:q]) : true}
    @title = params[:q].present? ? "Tag Search Results for '#{params[:q]}'" : "Tags"

    respond_to do |format|
      format.html
      format.json { 
        render json: @tags
      }
    end
  end
end
