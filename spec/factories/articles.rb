FactoryBot.define do
  factory :article do
    title    { "タイトル" }
    text     { "テキスト" }
    category

    trait :article_with_image do
      after(:build) do |article|
        article.images << build(:image, article: article)
      end
    end
  end
end
