class ScrapingsController < ApplicationController
  
  def index
    scraping
  end
  
  def update
    @scraping = Scraping.find(params[:id])
    @scraping.update(scraping_params)
    redirect_to articles_path if @scraping.save
  end

  private
  def scraping_params
    scraping
    params.permit(:code, :categories_id)
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
    params = {code: page, categories_id: 1}
    return params

    # pack = page.at_css(".box-main > h3").text
    # pack_info = pack.sub(/\([ァ-ヴ].+\)/,"")

    # name = page.css(".large").text
    # names = name.sub(/^\n/,"").sub(/\n$/,"").split("\n")
    # cards = names.map{|card| "「#{card}」" }
    # card_names = cards.join

    # img = page.css("img.alignnone").map{|image| image.attribute("src").value }
    # image_url = img.grep(/.*todays-card.+/)

    # title = "【VG】#{day}#{card_names}"
    # text = "#{pack_info}#{card_names}"
    # url = image_url
    # scraping = {title: title, text: text, categories_id: 1, images_attributes: url}
    # binding.pry
    # return scraping
  end
end
