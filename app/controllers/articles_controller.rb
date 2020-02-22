class ArticlesController < ApplicationController
  include Scrape

  def index
    @articles = Article.includes(:category, :images).order("created_at DESC")
  end

  def create(key)
    data = article_params(key)
    @article = Article.new(title: data[:title], text: data[:text], category_id: data[:category_id])
    image_save(data) if @article.save
  end

  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params(key)
    params = ActionController::Parameters.new(scraping(key))
    params.permit(:title, :text, :category_id, url: [])
  end
end
