class TagsController < ApplicationController
  def index
    @tags = Doc.all_tags
    respond_to do |format|
      format.json { 
        render json: #{ 
          #results: 
          @tags.map {|t| {'id': t, 'text': t}}.flatten 
        #} 
      }
    end
  end
end
