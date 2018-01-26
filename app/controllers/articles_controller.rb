class ArticlesController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret",
  #   except: [:index, :show]

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def index
      @articles = Article.all
  end

  def create
    # @article = Article.new(article_params)
    @article = Article.where(title: params[:title]).first_or_create(
        title: params[:title],
        text: params[:text]
        )
    if @article.save
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
