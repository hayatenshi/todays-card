class ArticlesController < ApplicationController
  def index
    # data = article_params
    # @article = Article.new(title: data[:title], text: data[:text], category_id: data[:category_id])
    # if @article.save
    #   image = @article.images.new(url: data[:url])
    #   image[:url] = image[:url].sub(/^\[\"/,"").sub(/\"\]$/,"")
    #   image.save
    # end
    @articles = Article.all.order("created_at DESC")
  end

  def create
    data = article_params
    @article = Article.new(title: data[:title], text: data[:text], category_id: data[:category_id])
    if @article.save
      image = @article.images.new(url: data[:url])
      image[:url] = image[:url].sub(/^\[\"/,"").sub(/\"\]$/,"")
      image.save
    end
    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: @article }
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params = ActionController::Parameters.new(scraping)
    params.permit(
      :title,
      :text,
      :category_id,
      url: []
    )
  end

  def scraping
    require "open-uri"
    require "nokogiri"
    require "date"
    
    day = Date.today.strftime("%-m/%-d")

    url = "https://cf-vanguard.com/todays-card/"
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)

    page = doc.css(".box-main")

    # article.titleの作成
    pack = page.at_css(".box-main > h3").text
    pack_info = pack.sub(/\([ァ-ヴ].+\)/,"")

    # article.textの作成
    name = page.css(".large").text
    names = name.sub(/^\n/,"").sub(/\n$/,"").split("\n")
    cards = names.map{ |card| "「#{card}」" }
    card_names = cards.join

    # article.images.urlの作成
    img = page.css("img.alignnone").map{ |image| image.attribute("src").value }
    url = img.grep(/.*todays-card.+/)

    title = "【VG】#{day}#{card_names}"
    text = "#{pack_info}#{card_names}"
    params = {title: title, text: text, category_id: 1, url: url}
    return params
  end
end
