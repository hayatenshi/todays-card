categories_list = [
  "ヴァンガード",
  "ヴァイスシュヴァルツ",
  "バディファイト",
  "Z/X"
]

categories_list.each do |list|
  Category.create(name: list)
end