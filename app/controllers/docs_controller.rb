class DocsController < ApplicationController
  def index
    doc_finder = DocFinder.find(params)

    @title = doc_finder.title
    @docs = doc_finder.results.page(params[:page])
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
