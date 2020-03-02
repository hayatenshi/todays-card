module Scrape
  extend ActiveSupport::Concern

  def image_save(data)
    image_url = data[:url]
    image_url.each do |img|
      image = @article.images.new(url: img)
      image[:url] = image[:url].sub(/^\[/,"").sub(/\]$/,"").gsub(/\"/,"")
      image.save
    end
  end

  def scraping(key)
    require "open-uri"
    require "nokogiri"
    require "date"

    day = Date.today.strftime("%-m/%-d")

    list = [
      "https://cf-vanguard.com/todays-card/",
      "https://ws-tcg.com/todays-card/",
      "https://fc-buddyfight.com/todays-card/",
    ]

    if key == 1
      url = list[0]
    elsif key == 2
      url = list[1]
    elsif key == 3
      url = list[2]
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
    end
  end

  def processing_vg(doc, day)
    page = doc.css(".box-main")

    pack_info = page.at_css(".box-main > h3").text.sub(/\([ァ-ヴ].+\)/,"")

    names = page.css(".large").text.sub(/^\n/,"").sub(/\n$/,"").split("\n")
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

    pack_days = page.css("h4").map{ |days| "#{days.text.sub(/▼/,"").sub(/\//,"年").sub(/（/,"\(").sub(/）/,"\)")}" }
    pack_names = page.css("h3 > a").map{ |title| "「#{title.text.sub(/\([ァ-ヴ].+\)/," ")}」" }

    count = 1
    pack_names.each do |name|
      pack_days.insert(count, "#{name}、")
      count += 2
    end
    pack_names = pack_names.join
    pack_info = pack_days.join.sub(/、$/,"")

    img = page.css("img.aligncenter").map{ |image| image.attribute("src").value }
    url = img.map{ |image_url| "https://ws-tcg.com#{image_url}" }

    title = "【WS】#{day}#{pack_names}収録カード"
    text = "【#{day} 更新カード】#{pack_info}収録"
    params = {title: title, text: text, category_id: 2, url: url}
    return params
  end

  def processing_bf(doc, day)
    page = doc.css(".w760")

    pack = page.css("h3").text.gsub(/\【.+\】/,"").split("\n")
    pack_info = pack.pop

    cards = pack.map{ |card| "「#{card}」" }
    card_names = cards.join

    url = page.css("img.alignleft").map{ |image| image.attribute("src").value }

    title = "【BF】#{day}#{card_names}"
    text = "#{pack_info}#{card_names}"
    params = {title: title, text: text, category_id: 3, url: url}
    return params
  end
end
