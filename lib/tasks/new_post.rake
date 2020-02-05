namespace :new_post do
  desc "サイトをスクレイピングし投稿する"
  task add_new_post: :environment do
    logger = Logger.new "log/recover_user_life.log"

    # Article.create(article_params)

    puts "ここまではクリア"
  end
end