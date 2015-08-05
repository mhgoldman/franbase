class TagsController < ApplicationController
  def index
    @tags = Doc.all_tags.select {|t| params[:q].present? ? t.include?(params[:q]) : true}

    respond_to do |format|
      format.json { 
        render json: @tags #@tags.map {|t| {'id': t, 'text': t}}.flatten 
      }
    end
  end
end
