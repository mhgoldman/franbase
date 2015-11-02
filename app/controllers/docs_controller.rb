class DocsController < ApplicationController
  before_action :set_doc, only: [:show, :edit, :update, :destroy]

  def index
    doc_finder = DocFinder.find(params)

    @title = doc_finder.title
    @docs = doc_finder.results.page(params[:page])

    respond_to do |format|
      format.html
      format.json {
        render json: @docs
      }
    end
  end

  def show
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
  end

  def update    
    if @doc.update(permitted_params)
      redirect_to @doc, notice: 'Doc updated!'
    else
      flash[:error] = @doc.errors.full_messages.to_sentence
      render 'edit'
    end
  end

  def destroy
    if @doc.destroy
      redirect_to docs_path, notice: 'Doc deleted!'
    end
  end

  def tags
    @tags = Doc.distinct(:tags)
  end

  private

  def permitted_params
    params.require(:doc).permit(:name, :content, :tags)
  end

  def set_doc
    @doc = Doc.find(params[:id])
  end
end
