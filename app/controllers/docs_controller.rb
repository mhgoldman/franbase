class DocsController < ApplicationController
  def index
    if params[:q].present?
      @docs = Doc.search(params[:q])
      @page_title = "Search Results for '#{params[:q]}'"
    elsif params[:tag]
      @docs = Doc.where(tags: params[:tag])
      @page_title = "Docs Tagged '#{params[:tag]}'"
    else
      @docs = Doc.all
      @page_title = "All Docs"
    end
  end

  def show
    @doc = Doc.find(params[:id])
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new(permitted_params)
    if @doc.save
      redirect_to docs_path, notice: 'Doc created!'
    else
      flash[:error] = @doc.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def edit
    @doc = Doc.find(params[:id])
  end

  def update
    @doc = Doc.find(params[:id])
    if @doc.update(permitted_params)
      redirect_to @doc, notice: 'Doc updated!'
    else
      flash[:error] = @doc.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def tags
    @tags = Doc.distinct(:tags)
  end

  private

  def permitted_params
    params.require(:doc).permit(:name, :content, :tags)
  end
end
