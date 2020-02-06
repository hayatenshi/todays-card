namespace :scrape do
  desc "ヴァンガードのページをスクレイピングし投稿する"
  task article_vg: :environment do
    logger = Logger.new "log/recover_user_life.log"
    ArticlesController.new.create(1)
  end

  desc "ヴァイスシュヴァルツのページをスクレイピングし投稿する"
  task article_ws: :environment do
    logger = Logger.new "log/recover_user_life.log"
    ArticlesController.new.create(2)
  end
  
  desc "バディファイトのページをスクレイピングし投稿する"
  task article_bf: :environment do
    logger = Logger.new "log/recover_user_life.log"
    ArticlesController.new.create(3)
  end

  # desc "Z/Xのページをスクレイピングし投稿する"
  # task article_zx: :environment do
  #   logger = Logger.new "log/recover_user_life.log"
  #   ArticlesController.new.create(4)
  # end
end