class ArticlesController < ApplicationController
  include Scrape

  def index
    @articles = Article.includes(:category, :images).order("created_at DESC")
  end

  def create(key)
    data = article_params(key)
    @article = Article.new(title: data[:title], text: data[:text], category_id: data[:category_id])
    if @article.save
      data[:url].each do |img|
        image = @article.images.new(url: img)
        image[:url] = image[:url].sub(/^\[/,"").sub(/\]$/,"").gsub(/\"/,"")
        unless image.save
          @article.destroy
          break
        end
      end
    end
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
