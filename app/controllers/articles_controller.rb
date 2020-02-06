class ArticlesController < ApplicationController
  def index
    # data = article_params(1)
    # @article = Article.new(title: data[:title], text: data[:text], category_id: data[:category_id])
    # if @article.save
    #   image_url = data[:url]
    #   image_url.each do |img|
    #     image = @article.images.new(url: img)
    #     image[:url] = image[:url].sub(/^\[/,"").sub(/\]$/,"").gsub(/\"/,"")
    #     image.save
    #   end
    # end
    @articles = Article.all.order("created_at DESC")
  end

  def create(key)
    data = article_params(key)
    @article = Article.new(title: data[:title], text: data[:text], category_id: data[:category_id])
    if @article.save
      image_url = data[:url]
      image_url.each do |img|
        image = @article.images.new(url: img)
        image[:url] = image[:url].sub(/^\[/,"").sub(/\]$/,"").gsub(/\"/,"")
        image.save
      end
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params(key)
    params = ActionController::Parameters.new(scraping(key))
    params.permit(
      :title,
      :text,
      :category_id,
      url: []
    )
  end

  def scraping(key)
    require "open-uri"
    require "nokogiri"
    require "date"

    day = Date.today.strftime("%-m/%-d")

    if key == 1
      url = "https://cf-vanguard.com/todays-card/"
    elsif key == 2
      url = "https://ws-tcg.com/todays-card/"
    elsif key == 3
      url = "https://fc-buddyfight.com/todays-card/"
    # elsif key == 4
    #   url =
    end

    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    doc = Nokogiri::HTML.parse(html, nil, charset)

    if key == 1
      processing_vg(doc, day)
    elsif key == 2
      processing_ws(doc, day)
    elsif key == 3
      processing_bf(doc, day)
    # elsif key == 4
    #   processing_zx(doc, day)
    end
  end

  def processing_vg(doc, day)
    page = doc.css(".box-main")

    pack = page.at_css(".box-main > h3").text
    pack_info = pack.sub(/\([ァ-ヴ].+\)/,"")

    name = page.css(".large").text
    names = name.sub(/^\n/,"").sub(/\n$/,"").split("\n")
    cards = names.map{ |card| "「#{card}」" }
    card_names = cards.join

    img = page.css("img.alignnone").map{ |image| image.attribute("src").value }
    url = img.grep(/.*todays-card.+/)

    title = "【VG】#{day}#{card_names}"
    text = "#{pack_info}#{card_names}"
    params = {title: title, text: text, category_id: 1, url: url}
    return params
  end

  def processing_ws(doc, day)
    page = doc.css(".entry-content")

    pack_day = page.at_css("#grt").text
    pack_a = pack_day.sub(/▼/,"").sub(/\//,"年")
    pack_title = page.at_css(".entry-content > h3 > a").text
    pack_b = pack_title.sub(/\([ァ-ヴ].+\)/," ")
    pack_info = "#{pack_a}「#{pack_b}」収録"

    img = page.css("img.aligncenter").map{ |image| image.attribute("src").value }
    url = img.map{|image_url| "https://ws-tcg.com#{image_url}"}

    title = "【WS】#{day}「#{pack_b}」収録カード"
    text = pack_info
    params = {title: title, text: text, category_id: 2, url: url}
    return params
  end

  def processing_bf(doc, day)
    page = doc.css(".w760")

    pack = page.css("h3").text
    pack_data = pack.gsub(/\【.+\】/,"").split("\n")
    pack_info = pack_data.pop

    cards = pack_data.map{ |card| "「#{card}」" }
    card_names = cards.join

    url = page.css("img.alignleft").map{ |image| image.attribute("src").value }

    title = "【BF】#{day}#{card_names}"
    text = "#{pack_info}#{card_names}"
    params = {title: title, text: text, category_id: 3, url: url}
    return params
  end
end
