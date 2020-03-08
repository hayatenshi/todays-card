FactoryBot.define do
  factory :image do
    url {File.open("#{Rails.root}/app/assets/images/sample/veb13_001.png")}
  end
end
