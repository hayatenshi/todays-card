class ArticlesController < ApplicationController
  #! OK
  def index
    @article = Article.new(article_params)
    @article.save
    @articles = Article.all.order("created_at DESC").page(params[:page]).per(10)
  end

  def create
    @article = Article.new(article_params)
    @article.save
  end

  #! OK
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
        [images_attributes: [:url]]
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
    params = {title: title, text: text, category_id: 1, images_attributes: url}
    return params
  end
end
